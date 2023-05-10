//
//  CardTemplate.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI


struct CardTemplate: View {
    
    @State private var backDegree = -90.0
    @State private var frontDegree = 0.0
    @State private var isFlipped = false
    @State private var isDragging = false
    @State private var isLiked = false
   
    @Binding var isMine: Bool
    
    /// DATA: 받아 올 유저 데이터
    let userInfo: UserInfo
    
    let durationAndDelay: CGFloat = 0.17
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in
                self.isDragging = true
                filpCardAnimation()
            }
            .onEnded { _ in
                self.isDragging = false
            }
    }
    
    var body: some View {
        ZStack {
            CardBack(degree: $backDegree, isMine: $isMine, userInfo: userInfo)
            CardFront(degree: $frontDegree, isLiked: $isLiked, isMine: $isMine, userInfo: userInfo)
        }
        .gesture(drag)
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

    @Binding var degree: Double
    @Binding var isLiked: Bool
    @Binding var isMine: Bool
    
    /// DATA: 받아 올 유저 데이터
    let userInfo: UserInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack {
                    
                    // MARK: - 오전/오후 세션 태그
                    HStack {
                        Image(systemName: "\(userInfo.isMorningSession ? "sun.and.horizon" : "sun.max")")
                        Text("\(userInfo.isMorningSession ? "오전" : "오후")")
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
                            Button {
                                /// 카드 커스텀 뷰로 이동
                                EditCardDesignView()
                            } label: {
                                Label("카드 커스텀", systemImage: "paintpalette")
                            }
                            Button {
                                /// 카드 내용 수정 뷰로 이동
                                EditCardInfoView()
                            } label: {
                                Label("명함 내용 수정", systemImage: "pencil")
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                        }
                    } else {
                        // MARK: - (타인의 명함일 경우) 즐겨찾기 아이콘
                        Button {
                            isLiked.toggle()
                            /// TODO: 해당 유저 데이터를 Update 하는 로직
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
                Text("\(userInfo.nicknameKOR)")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .padding(.top, 80)
                
                // MARK: - 영문 닉네임
                Text("\(userInfo.nicknameENG)")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding(.bottom, 12)
                
                // MARK: - 자기 소개
                Text("\(userInfo.selfDescription)")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 20))
            }
            .padding(22)
            
            Spacer()
            
            HStack {
                // MARK: - (내 명함일 경우) 카드 앞면에 큐알코드
                /// TODO: 큐알 로직 연결
                if isMine {
                    Image("qrExample")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .blendMode(.darken)
                }
                
                Spacer()
                // MARK: - 미모지 아바타 이미지
                /// TODO: API 연결
                Circle()
                    .frame(width: 100)
            }
            .padding(22)
            
        }
        .frame(height: 490)
        /// TODO: 컬러 extension 추가 후 적용
        .background(Color("\(userInfo.cardColor)"))
        .cornerRadius(32)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}



// MARK: - 명함 뒷면
struct CardBack: View {
    
    @Binding var degree: Double
    @Binding var isMine: Bool
    
    /// DATA: 받아 올 유저 데이터
    let userInfo: UserInfo
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Spacer()
            }
            
            HStack {
                // MARK: - "(닉네임), 칭찬해요!" 문구
                Text("\(userInfo.nicknameKOR), \n칭찬해요!")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .padding(.top, 80)
                Spacer()
            }
            .padding(.horizontal, 22)
            
            // MARK: - 미모지 아바타 이미지
            Circle()
                .frame(width: 185)
                .padding(.bottom, 30)
            
            // MARK: - 칭찬 리뷰로 이동
            NavigationLink {
                /// TODO: 칭찬 리뷰 뷰로 연결
            } label: {
                HStack {
                    Text("\(userInfo.nicknameKOR)이(가) 받은 칭찬 보러가기")
                    Image(systemName: "chevron.right")
                }
                .font(.system(size: 14))
                .fontWeight(.bold)            }
            
            Spacer()
                .frame(height: 60)
            
        }
        .frame(height: 490)
        /// TODO: 컬러 extension 추가 후 적용
        .background(Color("\(userInfo.cardColor)").opacity(0.6))
        .cornerRadius(32)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        
    }
}

struct CardTemplate_Previews: PreviewProvider {
    static var previews: some View {
        CardTemplate(isMine: .constant(true), userInfo: UserInfo(id: "", nicknameKOR: "헤이즐", nicknameENG: "Hazel", isMorningSession: false, selfDescription: "올라운더 디자이너로 활약 중입니다!✨", cardColor: "mainGreen"))
    }
}
