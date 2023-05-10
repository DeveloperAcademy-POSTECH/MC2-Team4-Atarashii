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
