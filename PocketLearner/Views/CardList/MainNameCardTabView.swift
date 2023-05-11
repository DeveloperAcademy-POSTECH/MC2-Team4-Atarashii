//
//  MyCardView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI


// MARK: - 유저의 정보를 담을 dummy 모델
/// TODO: 나중에 모델 파일로 분리 예정
struct UserInfo: Identifiable, Codable {
    let id: String
    let nicknameKOR: String
    let nicknameENG: String
    let isMorningSession: Bool // 세션 시간: 오전/오후 (if문으로 처리해주려고 이렇게 짰는데 적절하진 않는듯)
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
    
    @Namespace var QRanimation
    
    // MARK: - 카드 뷰 Segmented Control 섹션 카테고리
    enum cardViewCategories: String, CaseIterable {
        case myCard = "내 명함"
        case cardCollection = "수집한 명함"
        /// TODO: "즐겨찾기" 이름 변경 예정
        case likedCards = "즐겨찾기"
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                // MARK: - 상단 Segmented Control
                Picker("", selection: $cardViewSelection) {
                    ForEach(MainNameCardTabView.cardViewCategories.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
        
                
                // MARK: - 선택된 섹션 카테고리로 뷰 이동
                switch cardViewSelection {
                case .myCard:
                    MyCardView()
                case .cardCollection:
                    CardCollectionView()
                case .likedCards:
                    /// TODO: 파라미터로 즐겨찾기 데이터 넘겨주도록 수정
                    CardCollectionView()
                default:
                    MyCardView()
                }
                
            }
            .padding(38)
            
            
            // MARK: - 큐알 스캔을 위한 floating 버튼
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
                }
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
