//
//  CommentView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/09.
//

import SwiftUI

struct CommentView: View {
    // TODO : check from db. (Was I commented)
    @State var isCommented: Bool = false
    
    let commentTextBlackColor: UIColor = #colorLiteral(red: 0.3450980186, green: 0.3450980186, blue: 0.3450980186, alpha: 1)
    let commentBoxGrayColor: UIColor = #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)
    
    let text: String = """
    칭찬글 블라블라 어쩌구 칭찬글 블라블라라라
    라라라 어쩌구 칭찬글 블라블라 어쩌구
    칭찬글 블라블라 어쩌구 칭찬글 블라블라
    어쩌구 칭찬글 블라블라 어쩌구
    """
    let text2: String = "123"

    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                commentBox()
                commentBox()
                commentBox()
                commentBox()
                commentBox()
            }
            Spacer()
            Text("나도 헤이즐 칭찬하기")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding(.vertical, 19)
                .padding(.horizontal, 75)
                .background(
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color.black)
                )
                .padding(.top, 10)
        }
    }
    
    func commentBox() -> some View{
        return VStack(alignment: .leading){
            Text(text)
                .font(.system(size: 14, weight: .regular))
                .lineSpacing(6)
                .multilineTextAlignment(.leading)
            Spacer().frame(height: 21)
            HStack{
                Spacer()
                Text("From. Jeckmu")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(commentTextBlackColor))
            }
        }
        .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(commentBoxGrayColor))
            )
            .frame(width: 314)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView().previewDevice("iPhone 14")
    }
}
