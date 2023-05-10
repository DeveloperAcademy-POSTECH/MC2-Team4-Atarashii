//
//  CommentCreateView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/09.
//

import SwiftUI

struct CommentCreateView: View {
    //        @Binding var isEditing: Bool
    let isEditing:Bool = true
    
    let placeholder: String = "이 러너와의 협업 경험을 통해 알게 된 장점을 칭찬해주세요 :)"
    let borderGrayColor: UIColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
    let textGrayColor: UIColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
    let buttonDisabledGrayColor: UIColor = #colorLiteral(red: 0.8823529412, green: 0.8862745098, blue: 0.8862745098, alpha: 1)  // #E1E2E2
    let buttonEditAbledPinkColor: UIColor = #colorLiteral(red: 0.9568627451, green: 0.6784313725, blue: 0.7019607843, alpha: 1) // #F4ADB3
    @State var commentText: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("To. Hazel")
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
                            .fill( (commentText.count == 0) ? Color(buttonDisabledGrayColor) : (isEditing ? Color(buttonEditAbledPinkColor) : .black) )
                    )
            }.padding(.top, 20).disabled((commentText.count == 0))
            
        }.padding(.horizontal, 39).navigationTitle("칭찬 리뷰 수정")
    }
    
}

struct CommentCreateView_Previews: PreviewProvider {
    static var previews: some View {
        CommentCreateView().previewDevice("iPhone 14")
    }
}
