//
//  SelectMySkillView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/14.
//

import SwiftUI

struct SelectMySkillView: View {
    @State var activatedCircleNumber: Int = 2
    @State var headerTitleMessage: String = "나는 어떤 스킬을\n가지고 있나요?"
    @State var isHeaderDescriptionVisible: Bool = true
    @State var headerDescriptionMessage: String = "우리 모두는 주어진 예시 외에도, 다양한 스킬을 가지고\n있을 수 있어요. 원하는 보기가 없다면 당신만의\n스킬 키워드를 직접 입력해주세요!"
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber, headerTitleMessage:  headerTitleMessage, isHeaderDescriptionVisible: isHeaderDescriptionVisible, headerDescriptionMessage: headerDescriptionMessage)
            
            Button(action: {
                
            }){
                HStack(spacing: 7){
                    Image(systemName: "plus")
                        .font(.system(size: 15, weight: .medium))
                    Text("직접입력")
                        .font(.system(size: 15, weight: .medium))
                }
                .padding(.vertical, 5)
                .padding(.leading, 9)
                .padding(.trailing, 13)
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .stroke(lineWidth: 1)
                )
            }
            .padding(.leading, 38)
            .padding(.top, 29)
        }
    }
}

struct SelectMySkillView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMySkillView()
    }
}
