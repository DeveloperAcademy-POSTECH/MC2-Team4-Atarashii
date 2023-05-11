//
//  InitCardView.swift
//  bletest
//
//  Created by 주환 on 2023/05/08.
//

import SwiftUI

struct CreateNickNameView : View {
    @State var hasText: Bool = false
    @State var englishText: String = ""
    @State var koreanText: String = ""
    
    var body: some View {
        VStack{
            VStack{
                Text("아카데미에서 사용하고 계신\n닉네임을 알려주세요!")
                    .lineSpacing(CGFloat(10))
                    .bold()
                    .font(.system(size: 25))
                
                Text("`영문 닉네임` 에는 아카데미에서 사용하는 영문 닉네임을,\n `한글닉네임` 에는 닉네임의 발음을 한글로 적어주세요.")
                    .lineSpacing(5)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding()
            }
            VStack(spacing: 12) {
                RoundedTextFieldWithButton(text: $englishText, introText: "영문 닉네임")
                    .frame(width: 315, height: 52)
                RoundedTextFieldWithButton(text: $koreanText, introText: "한글 닉네임")
                    .frame(width: 315, height: 52)
            }
            
            Button(action: {
                // button action here
            }) {
                Text("입력 완료")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(width: 315, height: 52)
                    .background(!englishText.isEmpty && !koreanText.isEmpty ? hexStringToColor(hexString: "#F4ADB3"): Color.gray)
                    .cornerRadius(10)
            }
            .padding(.top, 100)


        }
    }
}


struct CreateNickNameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNickNameView()
            .previewDevice("iPhone 14")
    }
}


struct RoundedTextFieldWithButton: View {
    @Binding var text: String
    let introText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray)
            HStack {
                TextField("\(introText)", text: $text)
                    .padding(.horizontal, 10)
                
                Button(action: {
                    // Perform action here
                }) {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
            .padding(.horizontal, 10)
        }
    }
}
