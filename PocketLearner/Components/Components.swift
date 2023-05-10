//
//  Components.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/10.
//

import SwiftUI


/// 회색 둥근 테두리가 추가된, 글자 제한이 있는 TextField를 추가
/// - Parameters:
///   - placeholder: TextField에 들어갈 placeholder.
///   - commentText: TextField의 입력값으로 사용할 variable.
///   - letterLimit: 글자 수 제한의 글자수.
/// - Returns: VStack을 return. (TextField View)
func letterLimitTextField(placeholder: String, commentText: Binding<String>, letterLimit: Int) -> some View {
    return VStack {
        TextField(placeholder, text: commentText, axis: .vertical)
            .lineLimit(Int(letterLimit/20), reservesSpace: true)
            .font(.system(size: 14, weight: .regular))
            .padding()
            .multilineTextAlignment(.leading)
            .onReceive(commentText.wrappedValue.publisher.collect()) {
                commentText.wrappedValue = String($0.prefix(100))
            }
        
        HStack {
            Spacer()
            Text("\(commentText.wrappedValue.count)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(textGrayColor))
            + Text(" / \(letterLimit)자")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(Color(textGrayColor))
        }.padding()
    }.overlay(
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color(borderGrayColor), lineWidth: 2)
    )
}

/// CardGenerateViews에서 자주 사용되는 하단 버튼 탬플릿을  추가
/// - Parameters:
///   - title: 버튼의 title
///   - disableCondition: 버튼을 disable 할 수 있는 조건 (bool)
///   - action: 버튼을 눌렀을때의 액션
/// - Returns: Button을 return.
/// - 이후 네비게이션 구현시, 똑같은 lable을 사용하는 NavigationLink Component를 아래에 하나 더 구현해서, 뷰 전환되는 구간의 버튼은 해당 네비게이션 링크로 대체 요망
///
func cardGenerateViewsButton(title:String, disableCondition: Bool, action: @escaping ()->Void ) -> some View {
    return Button(action: action){
        Text(title)
            .foregroundColor(.white)
            .font(.system(size: 17, weight: .semibold))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(disableCondition ? Color(disabledNextButtonColor) : mainAccentColor)
                    .frame(width:321, height:48)

            )
    }
    .disabled(disableCondition)
}

