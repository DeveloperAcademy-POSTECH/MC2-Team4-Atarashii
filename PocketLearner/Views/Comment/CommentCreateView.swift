//
//  CommentCreateView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/09.
//

import SwiftUI

struct CommentCreateView: View {
    let placeholder: String = "이 러너와의 협업 경험을 통해 알게 된 장점을 칭찬해주세요 :)"
    let borderGrayColor: UIColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    let textGrayColor: UIColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
    let buttonDisabledGrayColor: UIColor = #colorLiteral(red: 0.8823529412, green: 0.8862745098, blue: 0.8862745098, alpha: 1)
    @State var commentText: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("To. Hazel")
                    .font(.system(size: 34, weight: .bold))
                Spacer()
            }
            VStack{
                TextField(placeholder, text: $commentText, axis: .vertical)
                    .lineLimit(5, reservesSpace: true)
                    .font(.system(size: 19, weight: .regular))
                    .padding()
                    .multilineTextAlignment(.leading)
                    .onReceive(commentText.publisher.collect()) {
                        self.commentText = String($0.prefix(100))
                    }
                HStack{
                    Spacer()
                    Text("\(commentText.count)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(textGrayColor))
                    + Text(" / 100자")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(textGrayColor))
                }.padding()
            }.overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(borderGrayColor), lineWidth: 2)
            )
            Text("작성 완료하기")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding(.vertical, 19)
                .padding(.horizontal, 125)
                .background(
                    RoundedRectangle(cornerRadius: 100)
                        .fill((commentText.count == 0) ? Color(buttonDisabledGrayColor) : .black )
                )
                .padding(.top, 30)
        }.padding(.horizontal, 39)
    }
    
}

struct CommentCreateView_Previews: PreviewProvider {
    static var previews: some View {
        CommentCreateView()
    }
}
