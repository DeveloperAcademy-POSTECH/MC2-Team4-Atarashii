//
//  CommentCreateView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/09.
//

import SwiftUI

struct CommentCreateView: View {
    let isEditing:Bool = true
    
    let placeholder: String = "이 러너와의 협업 경험을 통해 알게 된 장점을 칭찬해주세요 :)"

    @State var commentText: String = ""
    
    let learnerInfo: UserInfo
    
    var body: some View {
        VStack{
            HStack{
                Text("To. \(learnerInfo.nickKorean)")
                    .font(.system(size: 34, weight: .bold))
                Spacer()
            }
            letterLimitTextField(placeholder: "이 러너와의 협업 경험을 통해 알게 된\n장점을 칭찬해주세요 :)", commentText: $commentText, letterLimit: 100)
            
            Button(action: {
                // TODO : 작성 완료, 수정 시나리오
                if isEditing {
                    
                } else {
                    
                }
            }){
                Text("작성 완료하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 19)
                    .padding(.horizontal, 105)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .fill( (commentText.count == 0) ? Color(buttonDisabledGrayColor) : (isEditing ? mainAccentColor : .black) )
                    )
            }.padding(.top, 20).disabled((commentText.count == 0))
            
        }.padding(.horizontal, 39).navigationTitle("칭찬 리뷰 수정")
    }
    
}

