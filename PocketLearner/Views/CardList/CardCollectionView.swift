//
//  CardCollectionView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI


struct CardCollectionView: View {
    @EnvironmentObject var user: userData
    @EnvironmentObject var card: CardDetailData
    
    @State var viewModeSelection: CardViewMode = .slidingMode
    @State private var showingOptions = false
    @State private var selection = "None"
    
    @State var isMine: Bool = false
    // dummy (for CardTemplate)
    @State var isQRCodePresented: Bool = false
    @State var QRAnimation: Bool = false
    
    // MARK: - 타 러너의 유저 정보
    @Binding var learnerInfos: [UserInfo]
    
    // 즐겨찾기 관련
    @Binding var bookmarkIDs: [String]
    let isBookmarkSection: Bool
    
    // 랭킹 데이터 관련
    @Binding var rankingData: [RankData]
    @Binding var myRank: Int

    // MARK: - 슬라이드/갤러리 뷰 모드 카테고리
    enum CardViewMode: String, CaseIterable {
        case slidingMode
        case galleryMode
    }
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        GeometryReader { geometry in
        VStack {
            HStack {
                // MARK: - 슬라이드/갤러리 뷰 필터링 아이콘
                Menu {
                    Button {
                        // MARK: - 카드 슬라이딩 뷰로 변경
                        viewModeSelection = .slidingMode
                    } label: {
                        Label("슬라이딩 모드", systemImage: "slider.horizontal.below.rectangle")
                    }
                    Button {
                        // MARK: - 카드 갤러리 뷰로 변경
                        viewModeSelection = .galleryMode
                    } label: {
                        Label("갤러리 모드", systemImage: "slider.horizontal.below.square.filled.and.square")
                    }
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                // MARK: - 수집력 랭킹 배너
                collectionRankingBanner()
            }
            .padding(.vertical, 10)
            
        
            ScrollView {
                // MARK: - 수집한 명함들로 이동하는 단일 카드 뷰 리스트
                /// TODO: 실제 데이터 값으로 대체
                switch viewModeSelection {
                    
                // 슬라이딩 뷰로 카드 리스트 그리기
                /// TODO: 카드 넘겨지는 애니메이션 구현
                case .slidingMode:
                    ForEach(learnerInfos.indices, id:\.self) { index in
                        if !isBookmarkSection || bookmarkIDs.contains(learnerInfos[index].id){
                            CardTemplate(isMine: $isMine, isQRCodePresented: $isQRCodePresented, QRAnimation: $QRAnimation, learnerInfo: learnerInfos[index], bookmarkIDs: $bookmarkIDs)
                                .padding(.bottom, 34)
                        }
                    }
                    
                // 갤러리 뷰로 카드 리스트 그리기
                case .galleryMode:
                    LazyVGrid(columns: columns) {
                        ForEach(learnerInfos.indices, id: \.self) { index in
                            if !isBookmarkSection || bookmarkIDs.contains(learnerInfos[index].id){
                                    CardTemplate(isMine: $isMine, isQRCodePresented: $isQRCodePresented, QRAnimation: $QRAnimation, learnerInfo: learnerInfos[index], bookmarkIDs: $bookmarkIDs)
                                        .scaleEffect(0.5)
                                        .frame(width: geometry.size.width / 2, height: geometry.size.height / 2 - 50)
                                }
                            }
                        }
                    }
                }
                
                let _ = print(viewModeSelection)
                
            }
            .scrollIndicators(.hidden)
        }
    }
    
    
    // MARK: - 수집력 랭킹 배너 컴포넌트 (Method)
    func collectionRankingBanner() -> some View {
        Button {
            showingOptions = true
        } label: {
            if(myRank != 0){
                Text("당신의 수집력은 현재 \(myRank)위! 👈")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 12))
            } else{
                Text("명함 수집 랭킹을 확인하세요! 명함 수집을 시작하면, 랭킹에 등록됩니다! 👈")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 12))
            }
        }
        
        // MARK: - 수집력 랭킹 상세 내용 모달
        .sheet(isPresented: $showingOptions) {
            VStack {
                VStack(spacing: 8) {
                    Text("실시간")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                    Text("아카데미 명함 콜렉터 TOP 5")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                }
                /// TODO: 실제 데이터 연결
                /// TODO: 랭킹 순으로 나열되는 로직 구현
                ForEach(0...4, id:\.self) { index in
                    VStack {
                        Divider()
                            .padding(.bottom, 7)
                            .padding(.top, -3)
                            .padding(.horizontal, 40)
                        VStack(alignment: .leading) {
                            /// TODO: 텍스트 align leading으로 맞추기
                            HStack {
                                Text("**\(index+1)위** 👑")
                                if (rankingData.count >= index+1) {
                                    Text("**\(rankingData[index].nickKorean)** (\(rankingData[index].nickEnglish))")
                                    Text("**\(rankingData[index].cardCollectCount)**개")
                                }
                            }
                            .font(.system(size: 13))
                        }
                    }
                    .padding(.vertical, 5)
                    
                }
            }
            .presentationDetents([.medium, .large])
        }
    }
    
    
}

