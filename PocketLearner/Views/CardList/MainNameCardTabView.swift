//
//  MyCardView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI

// MARK: - 유저의 정보를 담을 모델
/// TODO: 나중에 모델 파일로 분리 예정
struct UserInfo: Identifiable, Codable {
    let id: String
    let nickKorean: String
    let nickEnglish: String
    let isSessionMorning: Bool // 세션 시간: 오전/오후
    
    let introduce: String
    let skills: [String]
    let skillLevel: [Int]
    let introduceSkill: String
    let growthTarget: String
    let wishSkills: [String]
    let wishSkillIntroduce: String
    let communicationType: Int
    let cooperationKeywords: [Bool]
    let cooperationIntroduce: String
    let cardColor: Int
    let cardPattern: Int
    let memoji: String
}

// MARK: - 카드 뷰 Segmented Control 섹션 카테고리
/// MainNameCardTabView, InitailCardMainView에서 사용
enum cardViewCategories: String, CaseIterable {
    case myCard = "내 명함"
    case cardCollection = "수집한 명함"
    /// TODO: "즐겨찾기" 이름 변경 예정
    case likedCards = "즐겨찾기"
}

struct RankData {
    let nickEnglish: String
    let nickKorean: String
    let cardCollectCount: Int
}


struct MainNameCardTabView: View {
    @EnvironmentObject var user: userData
    @EnvironmentObject var card: CardDetailData
    
    @State var cardViewSelection: cardViewCategories = .myCard
    @State var SegmentButtonPosition = CGPoint(x: 63.4, y: 22.2)
    
    @State var QRCodeScannerPresented: Bool = false
    @State var alertPresented: Bool = false
    
    
    // QR코드 스캔 결과
    @State var QRScanResult: scanResult = .none
    @State var isQRCodePresented: Bool = false
    
    @State var learnerIDs: [String] = []
    @State var learnerInfos: [UserInfo] = []
    


    @State var bookmarkIDs: [String] = []
    
    // 랭킹 데이터 관련
    @State var rankingData: [RankData] = []
    @State var myRank: Int = 0

    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    // MARK: - 상단 Segmented Control
                    if !isQRCodePresented{
                        CustomSegmentedControlButton()
                            .padding(.top, 30)
                    }
                    
                    
                    
                    // MARK: - 선택된 섹션 카테고리로 뷰 이동
                    switch cardViewSelection {
                    case .myCard:
                        // MARK: - 유저 필수 정보 값이 존재하지 않을 때는 초기화면 띄우기
                        /// 명함이 존재 vs. 존재하지 않는 시나리오를 구분하기 위해, 유저의 필수 입력값 중 하나를 체크하는 형식을 채택하려 함
                        /// TODO: 아직 유저 모델이 완성된 것이 아니기 때문에 추후에 유저의 id가 아닌 유저 모델의 특정 값으로 대체할 것.
                        if !card.id.isEmpty {
                            MyCardView(isQRCodePresented: $isQRCodePresented)
                                .frame(height: 636)
                        } else {
                            InitialCardNameView(cardViewSelection: $cardViewSelection)
                                .frame(height: 636)
                        }

                    case .cardCollection:
                        // MARK: - 교환한 명함이 존재하지 않을 때는 초기화면 띄우기
                        if !learnerIDs.isEmpty {
                            CardCollectionView(learnerInfos: $learnerInfos, bookmarkIDs: $bookmarkIDs, isBookmarkSection: false, rankingData: $rankingData, myRank: $myRank)
                                .frame(height: 636)
                        } else {
                            InitialCardNameView(cardViewSelection: $cardViewSelection)
                                .frame(height: 636)
                        }
                    case .likedCards:
                        // MARK: - 즐겨찾기 한 명함이 존재하지 않을 때는 초기화면 띄우기
                        if !bookmarkIDs.isEmpty {
                            CardCollectionView(learnerInfos: $learnerInfos, bookmarkIDs: $bookmarkIDs, isBookmarkSection: true, rankingData: $rankingData, myRank: $myRank)
                            .frame(height: 636)
                        } else {
                            InitialCardNameView(cardViewSelection: $cardViewSelection)
                                .frame(height: 636)
                        }
                    default:
                        MyCardView(isQRCodePresented: $isQRCodePresented)
                    }
                    
                }
                .padding(38)
                
                
                // MARK: - 큐알 스캔을 위한 floating 버튼
                // QR코드 생성 시 제거, 카드 생성 이전이면 보이지 않도록.
                if !isQRCodePresented && card.id != ""{
                    Button {
                        QRCodeScannerPresented = true
                    } label: {
                        ZStack{
                            Circle()
                                .fill(Color.white)
                                .frame(width: 70)
                            Text("+")
                                .font(.system(size: 65))
                                .foregroundColor(.accentColor)
                                .fontWeight(.medium)
                                .padding(.top, -9)
                        }
                        .shadow(color: Color.black.opacity(0.15), radius: 20)
                    }
                    .position(x: 320, y: 680)
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
                        case .already:
                            return Alert(title: Text("이미 명함을 교환한 상대입니다."))
                        }
                    }
                }
            }
        }.task {
            loadExchangeUsers(completion: {
                loadCollectedCards()
                loadBookmarkUsers()
            })
            loadUserRanking()
        }.onChange(of: self.cardViewSelection) { newValue in
            loadExchangeUsers(completion: {
                loadCollectedCards()
                loadBookmarkUsers()
            })
            loadUserRanking()

        }
    }
    

    func loadUserRanking() {
        let userColRef = db.collection("Users")
        
        rankingData.removeAll()
        
        userColRef.whereField("cardCollectCount", isGreaterThan: 0).order(by: "cardCollectCount", descending: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("순위 정보 로딩 실패: \(err)")
                } else {
                    var index = 0
                    for document in querySnapshot!.documents {
                        index += 1
                        let data = document.data()
                        
                        let id = data ["id"] as? String ?? ""
                        let nickEnglish = data["nickEnglish"] as? String ?? ""
                        let nickKorean = data["nickKorean"] as? String ?? ""
                        let cardCollectCount = data["cardCollectCount"] as? Int ?? 0
                        
                        rankingData.append(RankData(nickEnglish: nickEnglish, nickKorean: nickKorean, cardCollectCount: cardCollectCount))
                        
                        if id == user.id {
                            myRank = index
                        }
                    }
                    print(rankingData)
                }
            }
    }
  
    
    func loadExchangeUsers(completion: @escaping () -> Void) {
        learnerIDs.removeAll()
        // MARK: 모든 교환 상대 id Fetching
        let exchangeHistoryRef = db.collection("CardExchangeHistory")
        
        exchangeHistoryRef.whereField("id1", isEqualTo: user.id).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            for document in snapshot!.documents {
                if let id2 = document.data()["id2"] as? String {
                    learnerIDs.append(id2)
                }
            }
            
            print("id2 Array: \(learnerIDs)")
            completion()
        }
    }
    
    func loadBookmarkUsers() {
        bookmarkIDs.removeAll()
        // MARK: 모든 즐겨찾기 상대 id Fetching
        let bookmarkRef = db.collection("Bookmark")
        
        bookmarkRef.whereField("userID", isEqualTo: user.id).getDocuments { snapshot, error in
            if let error = error {
                print("북마크 정보 가져오기 실패: \(error)")
                return
            }
            
            for document in snapshot!.documents {
                if let counterpartID = document.data()["counterpartID"] as? String {
                    bookmarkIDs.append(counterpartID)
                }
            }
            
            print("id2 Array: \(bookmarkIDs)")
        }
    }
    
    func loadCollectedCards() {
        learnerInfos.removeAll()
        // TODO: 이거 싹 불러오는 식으로 되어있음. 나중에 Paging 필요.
        let cardDetail = db.collection("CardDetails")
        
        cardDetail.getDocuments { snapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            for document in snapshot!.documents {
                let documentData = document.data()
                
                let id = documentData["id"] as? String ?? ""
                
                if !learnerIDs.contains(id){
                    continue
                }
                let nickKorean = documentData["nickKorean"] as? String ?? ""
                let nickEnglish = documentData["nickEnglish"] as? String ?? ""
                let isSessionMorning = documentData["isSessionMorning"] as? Bool ?? true
                let introduce = documentData["introduce"] as? String ?? ""
                let skills = documentData["skills"] as? [String] ?? []
                let skillLevel = documentData["skillLevel"] as? [Int] ?? []
                let introduceSkill = documentData["introduceSkill"] as? String ?? ""
                let growthTarget = documentData["growthTarget"] as? String ?? ""
                let wishSkills = documentData["wishSkills"] as? [String] ?? []
                let wishSkillIntroduce = documentData["wishSkillIntroduce"] as? String ?? ""
                let communicationType = documentData["communicationType"] as? Int ?? 0
                let cooperationKeywords = documentData["cooperationKeywords"] as? [Bool] ?? []
                let cooperationIntroduce = documentData["cooperationIntroduce"] as? String ?? ""
                let cardColor = documentData["cardColor"] as? Int ?? 0
                let cardPattern = documentData["cardPattern"] as? Int ?? 0
                let memoji = documentData["memoji"] as? String ?? ""
                
                let learnerInfo = UserInfo(id: id, nickKorean: nickKorean, nickEnglish: nickEnglish, isSessionMorning: isSessionMorning, introduce: introduce, skills: skills, skillLevel: skillLevel, introduceSkill: introduceSkill, growthTarget: growthTarget, wishSkills: wishSkills, wishSkillIntroduce: wishSkillIntroduce , communicationType: communicationType , cooperationKeywords: cooperationKeywords , cooperationIntroduce: cooperationIntroduce, cardColor: cardColor, cardPattern: cardPattern , memoji: memoji )
                
                learnerInfos.append(learnerInfo)
            }
            
            // 이제 userInfos 배열에 UserInfo 구조체들이 들어 있습니다.
            print("LearnerInfo: \(learnerInfos)")
        }
    }
    
    
    
    // MARK: - 커스텀 SegmentedControl (Method)
    func CustomSegmentedControlButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 200, style: .continuous)
                .fill(Color.accentColor)
                .frame(width: 300, height: 45)
            
            HStack(spacing: 21) {
                Text("내 명함")
                    .font(.system(size: 13))
                    .opacity(0)
                Divider()
                    .frame(height: 15)
                Text("수집한 명함")
                    .font(.system(size: 13))
                    .opacity(0)
                Divider()
                    .frame(height: 15)
                Text("즐겨찾기")
                    .font(.system(size: 13))
                    .opacity(0)
                
            }
            
            RoundedRectangle(cornerRadius: 200, style: .continuous)
                .fill(Color.white)
                .frame(width: 105, height: 37)
                .position(SegmentButtonPosition)
                .animation(.easeInOut(duration: 0.3))

            
            HStack(spacing: 21) {
                // category: .myCard
                Button {
                    cardViewSelection = .myCard
                    SegmentButtonPosition = CGPoint(x: 63.4, y: 22.2)
                } label: {
                    Text("내 명함")
                        .font(.system(size: 13, weight: cardViewSelection == .myCard ? .bold : .regular))
                }
                .buttonStyle(buttonStyleNotOpacityChange())
                
                Divider()
                    .opacity(0)
                
                // category: .cardCollection
                Button {
                    cardViewSelection = .cardCollection
                    SegmentButtonPosition = CGPoint(x: 153, y: 22.2)
                } label: {
                    Text("수집한 명함")
                        .font(.system(size: 13, weight: cardViewSelection == .cardCollection ? .bold : .regular))
                }
                .buttonStyle(buttonStyleNotOpacityChange())
                
                Divider()
                    .opacity(0)
                
                // category: .likedCards
                Button {
                    cardViewSelection = .likedCards
                    SegmentButtonPosition = CGPoint(x: 250, y: 22.2)
                } label: {
                    Text("즐겨찾기")
                        .font(.system(size: 13, weight: cardViewSelection == .likedCards ? .bold : .regular))
                }
                .buttonStyle(buttonStyleNotOpacityChange())
            }
            
            
        }

    }

    /// 눌렀을 때 Opacity가 변하지 않는 ButtonStyle 재정의
    struct buttonStyleNotOpacityChange: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
}


enum scanResult{
    case none
    case success
    case fail
    case dbFail
    case expired
    case already
}






