//
//  CardGenerateViewHeader.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/09.
//

import SwiftUI

struct CardGenerateViewHeader: View {
    let unActivatedGray = #colorLiteral(red: 0.7506795526, green: 0.7506795526, blue: 0.7506795526, alpha: 1)
    @State var activatedCircleNumber: Int = 1
    @State var headerTitleMessage: String = "나를 소개하는\n한문장을 적어주세요!"
    @State var isHeaderDescriptionVisible: Bool = false
    @State var headerDescriptionMessage: String = "우리 모두는 주어진 예시 외에도, 다양한 스킬을 가지고 있을 수 있어요.\n원하는 보기가 없다면 당신만의 스킬 키워드를 직접 입력해주세요!"
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 17) {
                // Circles
                HStack {
                    
                    HStack{ // activated Circle Hstack
                        ForEach(0..<activatedCircleNumber) { number in
                            Circle()
                                .fill(Color.black)
                                .frame(width: 8, height: 8)
                        }
                    }
                    
                    HStack{ // activated Circle Hstack
                        ForEach(0..<9 - activatedCircleNumber) { number in
                            Circle()
                                .fill(Color(unActivatedGray))
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                
                Text(headerTitleMessage)
                    .font(.system(size: 25, weight: .bold))
                    .padding(.top, 36-17)
                
                if isHeaderDescriptionVisible == true {
                    Text(headerDescriptionMessage)
                        .font(.system(size: 11.5, weight: .light))
                }
                
                Spacer()
                
            }
            .padding(.leading, 37)
            .padding(.top, 18 + 52)
           
            Spacer()
        }
    }

    
}

struct CardGenerateViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        CardGenerateViewHeader().previewDevice("iPhone 14")
    }
}
