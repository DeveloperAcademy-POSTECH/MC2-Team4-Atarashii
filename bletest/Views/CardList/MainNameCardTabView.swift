//
//  MyCardView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI

struct MainNameCardTabView: View {
    
    @State var cardViewSelection: cardViewCategories = .myCard
    
    // MARK: - 카드 뷰 Segmented Control 섹션 카테고리
    enum cardViewCategories: String, CaseIterable {
        case myCard = "내 명함"
        case cardCollection = "수집한 명함"
        /// TODO: "즐겨찾기" 이름 변경 예정
        case likedCards = "즐겨찾기"
    }
    
    
    var body: some View {
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

    }
}





struct MainNameCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainNameCardTabView()
    }
}
