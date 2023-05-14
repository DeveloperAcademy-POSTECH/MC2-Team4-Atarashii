//
//  SkillTitleInputSheetView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/14.
//

import SwiftUI

struct SkillTitleInputSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = "" // 실제로 텍스트 필드에 입력되는데이터.
    @State var sendInputText: String = "" // 입력이 완료되어 부모뷰로 send 할 데이터
    @Binding var appendArray: [String]
    
    let letterLimit = 15
    var body: some View {
        VStack(spacing: 16){
            Text("스킬셋 키워드를 직접 입력해주세요!")
                .font(.system(size: 18, weight: .semibold))
                // 🔴 텍스트 Limit 설정
            
            HStack {
                TextField("스킬 키워드", text: $textFieldText)
                    .lineLimit(Int(letterLimit/20), reservesSpace: true)
                Button(action: {
                    // textFieldText를 지운다.
                    self.textFieldText = ""
                }){
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(textDismissGray)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(textFieldStrokeGray, lineWidth: 1)
            )

            cardGenerateViewsButton(title: "이 키워드 입력", disableCondition: self.textFieldText.isEmpty, action: {
                // 키워드를 부모 뷰로 전송.
                sendInputText = textFieldText
                appendArray.append(sendInputText)
                // 이 뷰를 dismiss 되게 만들어야
                dismiss()
            })
            .padding(.top, 16)
            Spacer()
        }
        .padding(.horizontal, 37)
        
        .padding(.top, 27)
    }
}

//struct SkillTitleInputSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        //SkillTitleInputSheetView()
//    }
//}
