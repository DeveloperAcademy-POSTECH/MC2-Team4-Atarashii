//
//  CardCollectionView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI

struct CardCollectionView: View {
    
    @State var viewModeSelection: CardViewMode = .slidingMode
    @State private var showingOptions = false
    @State private var selection = "None"
    
    // MARK: - 슬라이드/갤러리 뷰 모드 카테고리
    enum CardViewMode: String, CaseIterable {
        case slidingMode
        case galleryMode
    }
    
    
    var body: some View {
        VStack {
            HStack {
                // MARK: - 슬라이드/갤러리 뷰 필터링 아이콘
                Image(systemName: "slider.horizontal.3")
                    .contextMenu {
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
                    }
                
                Spacer()
                
                // MARK: - 수집력 랭킹 배너
                collectionRankingBanner()
                
                Spacer()
            }
            .padding(.vertical, 20)
            
            
            ScrollView {
                // MARK: - 수집한 명함들로 이동하는 단일 카드 뷰 리스트
                /// TODO: 실제 데이터 값으로 대체
                switch viewModeSelection {
                    
                    // 슬라이딩 뷰로 카드 리스트 그리기
                    /// TODO: - 카드 넘겨지는 애니메이션 구현
                case .slidingMode:
                    ForEach(0...10, id:\.self) { _ in
                        CardTemplate()
                            .padding(.bottom, 34)
                    }
                    
                    // 갤러리 뷰로 카드 리스트 그리기
                    /// TODO: 갤러리 뷰 구현
                case .galleryMode:
                    ForEach(0...1, id:\.self) { _ in
                        CardTemplate()
                            .padding(.bottom, 34)
                    }
                    
                }
                
                let _ = print(viewModeSelection)
                
            }
        }
    }
    
    
    // MARK: - 수집력 랭킹 배너 컴포넌트 메서드
    func collectionRankingBanner() -> some View {
        /// TODO: 순위 값 데이터로 대체
        Button {
            showingOptions = true
        } label: {
            Text("당신의 수집력은 현재 6위 🏆")
                .padding(10)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(12)
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
                                Text("**스위머** (Swimmer)")
                                // 더미 데이터로 랜덤 값이 들어있음
                                Text("**\(Int.random(in: 0..<60))**개")
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




struct CardCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CardCollectionView()
    }
}
