//
//  InitCardView.swift
//  bletest
//
//  Created by 주환 on 2023/05/08.
//

import SwiftUI

struct CreateNickNameView : View {
    @EnvironmentObject var user: userData
    @State var hasText: Bool = false
    @State var englishText: String = ""
    @State var koreanText: String = ""
    
    @State var nextPage: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("아카데미에서 사용하고 계신\n닉네임을 알려주세요!")
                            .lineSpacing(CGFloat(10))
                            .bold()
                            .font(.system(size: 25))
                            .multilineTextAlignment(.leading)
                        
                        Text("영문 닉네임에는 아카데미에서 사용하는 영문 닉네임을,\n한글 닉네임에는 닉네임의 발음을 한글로 적어주세요.")
                            .lineSpacing(5)
                            .font(.system(size: 12))
                            .foregroundColor(mainSubColor)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 10).padding(.bottom, 15)
                        
                    }.padding(.leading, 40)
                    Spacer()
                }
                VStack(spacing: 12) {
                    RoundedTextFieldWithButton(text: $englishText, introText: "영문 닉네임")
                        .frame(width: 315, height: 52)
                    RoundedTextFieldWithButton(text: $koreanText, introText: "한글 닉네임")
                        .frame(width: 315, height: 52)
                }
                
                Button(action: {
                    // button action here
//                    applyNickname()
                    nextPage = true
                }) {
                    Text("입력 완료")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(width: 315, height: 52)
                        .background(!englishText.isEmpty && !koreanText.isEmpty ? mainAccentColor : Color(buttonDisabledGrayColor))
                        .cornerRadius(10)
                }.disabled(englishText.isEmpty || koreanText.isEmpty)
                    .padding(.top, screenHeight*0.05)
                    .padding(.bottom, screenHeight*0.05)
                    .navigationDestination(isPresented: $nextPage){
                        CreateTimeView(nickEnglish: englishText, nickKorean: koreanText)
                    }
            }
        }
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
