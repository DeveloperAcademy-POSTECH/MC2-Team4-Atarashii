//
//  InitCardView.swift
//  bletest
//
//  Created by 주환 on 2023/05/08.
//

import SwiftUI

struct CreateNickNameView : View {
    
    @State var englishName = ""
    @State var koreanName = ""
    
    var body: some View {
        VStack{
            VStack{
                Text("아카데미에서 사용하고 계신\n닉네임을 알려주세요!")
                    .bold()
                    .font(.system(size: 25))
                
                Text("`영문 닉네임` 에는 아카데미에서 사용하는 영문 닉네임을,\n `한글닉네임` 에는 닉네임의 발음을 한글로 적어주세요.")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                    .padding(.vertical,20)
            }
            VStack {
                TextField("영문 닉네임", text: $englishName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .frame(width: 315,height: 46)
                TextField("한글 닉네임", text: $koreanName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .frame(width: 315,height: 46)
                
                    .padding(.vertical, 12)
            }

            
            
            
            Button(action: {
                // button action here
            }) {
                Text("입력 완료")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(width: 315, height: 52)
                    .background(Color.gray)
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
