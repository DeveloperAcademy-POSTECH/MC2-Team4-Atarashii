//
//  MyCardView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI


// MARK: - 카드 뷰 Segmented Control 섹션 카테고리
/// MainNameCardTabView, InitailCardMainView에서 사용
enum cardViewCategories: String, CaseIterable {
    case myCard = "내 명함"
    case cardCollection = "수집한 명함"
    /// TODO: "즐겨찾기" 이름 변경 예정
    case likedCards = "즐겨찾기"
}


// MARK: - 유저의 정보를 담을 dummy 모델
/// TODO: 나중에 모델 파일로 분리 예정
struct UserInfo: Identifiable, Codable {
    let id: String
    let nickKorean: String
    let nickEnglish: String
    let isSessionMorning: Bool // 세션 시간: 오전/오후 (if문으로 처리해주려고 이렇게 짰는데 적절하진 않는듯)
    let selfDescription: String
    let cardColor: String // 커스텀 명함의 컬러 값 (Color Asset 이름) /// TODO: Color 타입으로 바꾸고 Color.swift에 있는 것으로 쓰기
    //    let cardBg: String // 커스텀 명함의 백그라운드 스타일
    //    let profileMemoji: String // (데이터타입 확실치 않음)
    //    let isLiked: Bool // 즐겨찾기 여부 (얘 때문에 북마크 버튼 안에서 전체 유저 값을 update 해줘야 됨)
}


struct MainNameCardTabView: View {
    @EnvironmentObject var user: userData
    
    @State var cardViewSelection: cardViewCategories = .myCard
   
    @State var QRCodeScannerPresented: Bool = false
    @State var alertPresented: Bool = false
    
    // QR코드 스캔 결과
    @State var QRScanResult: scanResult = .none
    @State var isQRCodePresented: Bool = false
<<<<<<< HEAD
    
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: - 상단 Segmented Control
                if !isQRCodePresented{
                    Picker("", selection: $cardViewSelection) {
                        ForEach(cardViewCategories.allCases, id: \.self) { category in
                            Text(category.rawValue)
=======
    
    @State var isMyCardInited: Bool = false
    
    // MARK: - 카드 뷰 Segmented Control 섹션 카테고리
    enum cardViewCategories: String, CaseIterable {
        case myCard = "내 명함"
        case cardCollection = "수집한 명함"
        /// TODO: "즐겨찾기" 이름 변경 예정
        case likedCards = "즐겨찾기"
    }
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    // MARK: - 상단 Segmented Control
                    if !isQRCodePresented{
                        Picker("", selection: $cardViewSelection) {
                            ForEach(MainNameCardTabView.cardViewCategories.allCases, id: \.self) { category in
                                Text(category.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    // MARK: - 선택된 섹션 카테고리로 뷰 이동
                    switch cardViewSelection {
                    case .myCard:
                        // 명함 생성 여부 확인 후, 분화
                        if isMyCardInited{
                            MyCardView(isQRCodePresented: $isQRCodePresented)
                        }else{
                            InitialCardNameView()
                        }
                    case .cardCollection:
                        CardCollectionView()
                    case .likedCards:
                        // TODO: 파라미터로 즐겨찾기 데이터 넘겨주도록 수정
                        CardCollectionView()
                    default:
                        MyCardView(isQRCodePresented: $isQRCodePresented)
                    }
                    
                }
                .padding(38)
                
                
                // MARK: - 큐알 스캔을 위한 floating 버튼
                if !isQRCodePresented && isMyCardInited{
                    Button {
                        QRCodeScannerPresented = true
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 70)
                            Image(systemName: "plus")
                                .font(.system(size: 50))
                                .foregroundColor(.black)
                        }
                        .shadow(radius: 20)
                    }
                    .position(x: 320, y: 650)
                    .sheet(isPresented: $QRCodeScannerPresented){
                        QRCodeScannerView(QRScanResult: $QRScanResult) { code, deviceName in
                            QRCodeScannerPresented = false
                            alertPresented = true
                        }.environmentObject(user)
                    }.alert(isPresented: $alertPresented){
                        switch QRScanResult.self{
                        case .success:
                            return Alert(title: Text("명함이 성공적으로 교환되었습니다!"))
                        case .none:
                            return Alert(title: Text("알 수 없는 오류 발생. 다시 시도해주세요."))
                        case .fail:
                            return Alert(title: Text("QR코드 스캔 실패. 다시 시도해주세요."))
                        case .dbFail:
                            return Alert(title: Text("QR코드를 스캔하였으나, DB에 성공적으로 저장되지 않았습니다. 다시 시도해주세요."))
                        case .expired:
                            return Alert(title: Text("QR코드 유효기간이 만료되었습니다. 다시 시도해주세요."))
>>>>>>> main
                        }
                    }
                }
<<<<<<< HEAD
        
                
                // MARK: - 선택된 섹션 카테고리로 뷰 이동
                switch cardViewSelection {
                case .myCard:
                    // MARK: - 유저 필수 정보 값이 존재하지 않을 때는 초기화면 띄우기
                    /// 명함이 존재 vs. 존재하지 않는 시나리오를 구분하기 위해, 유저의 필수 입력값 중 하나를 체크하는 형식을 채택하려 함
                    /// TODO: 아직 유저 모델이 완성된 것이 아니기 때문에 추후에 유저의 id가 아닌 유저 모델의 특정 값으로 대체할 것.
//                    if !user.id.isEmpty {
//                        MyCardView(isQRCodePresented: $isQRCodePresented)
//                        .frame(height: 636)
//                    } else {
                    InitailCardMainView(cardViewSelection: $cardViewSelection)
                        .frame(height: 636)
//                    }
                    
                case .cardCollection:
                    // MARK: - 교환한 명함이 존재하지 않을 때는 초기화면 띄우기
//                    if !user.cardCollectCount == 0 {
//                        CardCollectionView()
//                        .frame(height: 636)
//                    } else {
                    InitailCardMainView(cardViewSelection: $cardViewSelection)
                        .frame(height: 636)
//                    }
                case .likedCards:
                    // MARK: - 즐겨찾기 한 명함이 존재하지 않을 때는 초기화면 띄우기
                    /// TODO: 파라미터로 즐겨찾기 데이터 넘겨주도록 수정
//                    if !user.id.isLiked == 0 {
//                        CardCollectionView()
//                        .frame(height: 636)
//                    } else {
                    InitailCardMainView(cardViewSelection: $cardViewSelection)
                        .frame(height: 636)
//                    }
                default:
                    MyCardView(isQRCodePresented: $isQRCodePresented)
                }
                
            }
            .padding(38)
            
            
            // MARK: - 큐알 스캔을 위한 floating 버튼
            if !isQRCodePresented{
                Button {
                    QRCodeScannerPresented = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 70)
                        Image(systemName: "plus")
                            .font(.system(size: 50))
                            .foregroundColor(.black)
                    }
                    .shadow(color: Color.black.opacity(0.15), radius: 20)
                }
                .position(x: 320, y: 630)
                .sheet(isPresented: $QRCodeScannerPresented){
                    QRCodeScannerView(QRScanResult: $QRScanResult) { code, deviceName in
                        QRCodeScannerPresented = false
                        alertPresented = true
                    }.environmentObject(user)
                }.alert(isPresented: $alertPresented){
                    switch QRScanResult.self{
                    case .success:
                        return Alert(title: Text("명함이 성공적으로 교환되었습니다!"))
                    case .none:
                        return Alert(title: Text("알 수 없는 오류 발생. 다시 시도해주세요."))
                    case .fail:
                        return Alert(title: Text("QR코드 스캔 실패. 다시 시도해주세요."))
                    case .dbFail:
                        return Alert(title: Text("QR코드를 스캔하였으나, DB에 성공적으로 저장되지 않았습니다. 다시 시도해주세요."))
                    case .expired:
                        return Alert(title: Text("QR코드 유효기간이 만료되었습니다. 다시 시도해주세요."))
                    }
                }
=======
            }
        }.task {
            loadUserData()
        }
    }
    
    
    /// Load user card detail data from DB. if user card data is not initialized, set isMyCardInited to false.
    func loadUserData() {
        let userCardDocRef = db.collection("CardDetails").document(user.id)
        
        userCardDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("My Card is Initialized - MainNameCardTabView: loadUserData")
                isMyCardInited = true
            } else {
                print("My Card is not Initialized - MainNameCardTabView: loadUserData")
                isMyCardInited = false
>>>>>>> main
            }
        }
    }
}


enum scanResult{
    case none
    case success
    case fail
    case dbFail
    case expired
}
