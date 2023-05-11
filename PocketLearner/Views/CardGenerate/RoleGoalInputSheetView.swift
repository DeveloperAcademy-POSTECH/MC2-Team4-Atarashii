//
//  RoleGoalInputSheetView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/11.
//

import SwiftUI

struct RoleGoalInputSheetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = "" // 실제로 텍스트 필드에 입력되는데이터.
    @Binding var sendInputText: String // 입력이 완료되어 부모뷰로 send 할 데이터
    let letterLimit = 5
    
    var body: some View {
        VStack(spacing: 16){
            Text("성장 목표를 직접 입력해 주세요!")
                .font(.system(size: 18, weight: .semibold))
                // 🔴 텍스트 Limit 설정
            
            HStack {
                TextField("T자형 인재", text: $textFieldText)
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
