//
//  RoleGoalInputSheetView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/11.
//

import SwiftUI

struct RoleGoalInputSheetView: View {
    @Binding var textFieldText: String
    var body: some View {
        VStack(spacing: 16){
            Text("성장 목표를 직접 입력해 주세요!")
                .font(.system(size: 18, weight: .semibold))
            
            HStack {
                TextField("T자형 인재", text: $textFieldText)
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
                // 
            })
            .padding(.top, 16)
            Spacer()
        }
        .padding(.horizontal, 37)
        
        .padding(.top, 27)
    }
        
}

//struct RoleGoalInputSheetView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        RoleGoalInputSheetView()
//    }
//
//}
