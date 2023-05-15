//
//  CardTemplate.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct CardTemplate: View {
    @EnvironmentObject var user: userData
    @EnvironmentObject var card: CardDetailData
    
    @State private var backDegree = -90.0
    @State private var frontDegree = 0.0
    @State private var isFlipped = false
    @State private var isDragging = false
    @State private var isLiked = false
    
    @Binding var isMine: Bool
    @Binding var isQRCodePresented: Bool
    @Binding var QRAnimation: Bool
    
    @State var goCardCustomView: Bool = false
    @State var goCardDetailEditView: Bool = false
    
    let durationAndDelay: CGFloat = 0.1
    
    let learnerInfo: UserInfo
    @Binding var bookmarkIDs: [String]
    
    @State private var offset = CGSize.zero
    
    
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 20)
            .onChanged { gesture in
                offset.width = gesture.translation.width
                offset.height = gesture.translation.height
                filpCardAnimation()
            }
            .onEnded { _ in
                offset = .zero
            }
    }
    
    var body: some View {
        ZStack {
            CardBack(degree: $backDegree, isMine: $isMine, learnerInfo: learnerInfo)
            CardFront(degree: $frontDegree, isLiked: $isLiked, isMine: $isMine, isQRCodePresented: $isQRCodePresented, QRAnimation: $QRAnimation, learnerInfo: learnerInfo, bookmarkIDs: $bookmarkIDs)
        }
        .gesture(drag)
        .task {
            if bookmarkIDs.contains(learnerInfo.id){
                isLiked = true
            }
        }
    }
    
    
    // MARK: - 명함 탭했을 때 뒤집는 액션 (Method)
    func filpCardAnimation() {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        }
    }
    
    
}



// MARK: - 명함 앞면
struct CardFront: View {
    @EnvironmentObject var user : userData
    @EnvironmentObject var card : CardDetailData
    
    @Binding var degree: Double
    @Binding var isLiked: Bool
    @Binding var isMine: Bool
    
    @Binding var isQRCodePresented: Bool
    @Binding var QRAnimation: Bool
    
    let learnerInfo: UserInfo
    
    @Binding var bookmarkIDs: [String]
    @State var retrievedImage = UIImage()


    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading) {
                    HStack {
                        // MARK: - 오전/오후 세션 태그
                        HStack {
                            Image(systemName: "\((isMine ? user.isSessionMorning : learnerInfo.isSessionMorning) ? "sun.and.horizon" : "sun.max")")
                            Text("\((isMine ? user.isSessionMorning : learnerInfo.isSessionMorning) ? "오전" : "오후")")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(22)
                        
                        Spacer()
                        /// isMine을 통해 내 명함, 타 러너의 명함을 구분
                        if isMine {
                            // MARK: - (내 명함일 경우) 편집 기능이 담긴 More Action 아이콘
                            Menu {
                                // MARK: - 카드 커스텀 뷰로 이동
                                NavigationLink(destination: {
                                    EditCardDesignView(retrievedImage: $retrievedImage)
                                }){
                                    Label("카드 커스텀", systemImage: "paintpalette")
                                }
                                // MARK: - 명함 내용 수정
                                NavigationLink(destination: {
                                    EditCardInfoView(retrievedImage: $retrievedImage)
                                }){
                                    Label("명함 내용 수정", systemImage: "pencil")
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                                    .padding(10)
                            }
                        } else {
                            // MARK: - (타인의 명함일 경우) 즐겨찾기 아이콘
                            Button {
                                if isLiked {
                                    //북마크 삭제
                                    deleteBookmark()
                                } else {
                                    //북마크 생성
                                    createBookmark()
                                }
                                isLiked.toggle()
                                bookmarkIDs.append(learnerInfo.id)
                            } label: {
                                if isLiked {
                                    Image(systemName: "bookmark.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.black)
                                    
                                } else {
                                    Image(systemName: "bookmark")
                                        .font(.system(size: 30))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    
                    // MARK: - 국문 닉네임
                    Text("\(isMine ? user.nickKorean : learnerInfo.nickKorean)")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .padding(.top, 80)
                    
                    // MARK: - 영문 닉네임
                    Text("\(isMine ? user.nickEnglish : learnerInfo.nickEnglish)")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.bottom, 12)
                    
                    // MARK: - 자기 소개
                    Text("\(isMine ? card.introduce : learnerInfo.introduce)")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 20))
                }
                .padding(22)
                
                Spacer()
                
                HStack {
                    // MARK: - (내 명함일 경우) 카드 앞면에 큐알코드
                    if isMine {
                        Button(action: {
                            QRAnimation.toggle()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.6) {
                                withAnimation(.linear(duration: 0.5)) {
                                    isQRCodePresented = true
                                }
                            }
                        }){
                            Image("qrExample")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                                .blendMode(.darken)
                        }
                        .background(QRAnimation ? .white : .clear)
                        .scaleEffect(QRAnimation ? 5 : 1)
                        // offset 하드코딩.... 인데 아이폰14 기준이라 괜찮을지도.... 방법이 없음....
                        .offset(x: QRAnimation ? 105 : 0,
                                y: QRAnimation ? -170 : 0)
                        .animation(.easeOut(duration: 0.8))
                    }
                    
                    Spacer()
                    // MARK: - 미모지 아바타 이미지
                    if card.memoji != "" {
                        Image(uiImage: retrievedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 140)
                            .clipShape(Circle())
                            .opacity(0)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .frame(width: 140)
                            .foregroundColor(gaugeGrayColor)
                            .opacity(0)
                    }
                }
                .padding(22)
                
            }
            .frame(height: 490)
            /// TODO: 컬러 extension 추가 후 적용
            .background(cardColorList[isMine ? card.cardColor : learnerInfo.cardColor])
            .cornerRadius(32)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
            
            
            // MARK: 명함 패턴
            VStack {
                Image("\(cardPatternList[isMine ? card.cardPattern : learnerInfo.cardPattern])")
                    .cornerRadius(32)
                    .blendMode(.overlay)
                    .opacity(0.5)
            }
            .frame(height: 490)
            .cornerRadius(32)
            .allowsHitTesting(false)
            
            
            
            // MARK: - 미모지 추가 영역 (패턴에 안가려지게 밖으로 뺌)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if card.memoji != "" {
                        Image(uiImage: retrievedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 140)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .frame(width: 140)
                            .foregroundColor(gaugeGrayColor)
                    }
                }
                .padding(22)
            }
            .frame(height: 490)
        }
        .onAppear {
                getPhotos()
        }
        .onChange(of: self.card.memoji) { newValue in
            print("IMAGE CHANGED")
            getPhotos()
        }
    }
    
    func deleteBookmark() {
        let bookmarkDocRef = db.collection("Bookmark").document("\(user.id)_\(learnerInfo.id)")
        
        bookmarkDocRef.delete(){ err in
            if let err = err {
                print("즐겨찾기 삭제 실패!: \(err)")
            } else {
                print("즐겨찾기 삭제 성공!")
            }
        }
        
        if let index = bookmarkIDs.firstIndex(of: learnerInfo.id){
            bookmarkIDs.remove(at: index)
        }
    }
    
    func createBookmark() {
        let bookmarkDocRef = db.collection("Bookmark").document("\(user.id)_\(learnerInfo.id)")
        
        bookmarkDocRef.setData([
            "userID": user.id,
            "counterpartID": learnerInfo.id,
            "bookmarkDate": Date()
        ]){ err in
            if let err = err {
                print("즐겨찾기 등록 실패!: \(err)")
            } else {
                print("즐겨찾기 등록 성공!")
            }
        }
    }
    
    
    
    // MARK: - Storage: retrievePhotos() (Method)
    /// Storage에서 이미지 가져오기
    /// 중복 함수... 이렇게 쓰면 안될텐데..
    func getPhotos() {
        // Get the data from the database
        let docRef = Firestore.firestore().collection("CardDetails").document(user.id)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let imagePath = document.get("memoji")
                print("CARDFRONT_IMAGEPATH: ", imagePath ?? "")
                
                // Get a reference to storage
                let storageRef = Storage.storage().reference()
                
                // Specify the path
                let fileRef = storageRef.child(imagePath as! String)
                
                // Retrieve the data
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    // Check for errors
                    if error == nil && data != nil {
                        // Create a UIImage and put it into display
                        if let image = UIImage(data: data!) {
                            DispatchQueue.main.async {
                                retrievedImage = image
                            }
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}



// MARK: - 명함 뒷면
struct CardBack: View {
    @EnvironmentObject var user : userData
    @EnvironmentObject var card : CardDetailData
    @Binding var degree: Double
    @Binding var isMine: Bool
    
    let learnerInfo: UserInfo
    
    var body: some View {
        ZStack {
            Image("cardBack")
                .blendMode(.overlay)
            
            VStack(alignment: .center, spacing: 10) {
                HStack {
                    Spacer()
                }
                
                HStack {
                    // MARK: - "(닉네임), 칭찬해요!" 문구
                    Text("\(isMine ? user.nickKorean : learnerInfo.nickKorean), \n칭찬해요!")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .padding(.top, 80)
                    Spacer()
                }
                .padding(.horizontal, 22)
                
                // MARK: - 미모지 아바타 이미지
//                Circle()
//                    .frame(width: 185)
//                    .padding(.bottom, 30)
                
                // MARK: - 칭찬 리뷰로 이동
                NavigationLink {
                    CommentView(isMine: isMine, learnerInfo: learnerInfo).navigationTitle("칭찬 리뷰")
                } label: {
                    HStack {
                        Text("\(isMine ? user.nickKorean : learnerInfo.nickKorean)이(가) 받은 칭찬 보러가기")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                }
                
                Spacer()
                    .frame(height: 60)
                
            }
            .frame(height: 490)
            /// TODO: 컬러 extension 추가 후 적용
            .background(cardColorList[isMine ? card.cardColor : learnerInfo.cardColor].opacity(0.5))
            .cornerRadius(32)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
            
        }
    }
}
