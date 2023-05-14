//
//  CardGenerateViewHeader.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/09.
//

import SwiftUI

struct CardGenerateViewHeader: View {
    @State var activatedCircleNumber: Int = 1
    @State var headerTitleMessage: String = "나의 커뮤니케이션 타입은?"
    @State var isHeaderDescriptionVisible: Bool = true
    @State var headerDescriptionMessage: String = "레베카 함께 했던 팀워크 워크샵을 기억하시나요?"
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 17) {
                // Circles
                HStack {
                    HStack{ // activated Circle Hstack
                        ForEach(0..<activatedCircleNumber) { _ in
                            Circle()
                                .fill(mainAccentColor)
                                .frame(width: 8, height: 8)
                        }
                    }
                    HStack{ // activated Circle Hstack
                        ForEach(0..<6 - activatedCircleNumber) { _ in
                            Circle()
                                .fill(softOrange)
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                Text(headerTitleMessage)
                    .font(.system(size: 25, weight: .bold))
                    .padding(.top, 36-17)
                
                if isHeaderDescriptionVisible == true {
                    Text(headerDescriptionMessage)
                        .font(.system(size: 13, weight: .light))
                }
            }
            .padding(.leading, 37)
            .padding(.top, 30)
            Spacer()
        }
    }
}

struct CardGenerateViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        CardGenerateViewHeader().previewDevice("iPhone 14")
    }
}
