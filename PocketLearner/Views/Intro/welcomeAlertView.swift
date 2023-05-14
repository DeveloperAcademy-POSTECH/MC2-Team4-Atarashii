//
//  welcomeAlertView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/15.
//

import SwiftUI

struct welcomeAlertView: View {
    @EnvironmentObject var user: userData
    
    let onButtonTapped: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 10)
                .frame(width: 335, height: 330)
            
            VStack{
                Image("mainCharacter")
                    .resizable()
                    .imageScale(.large)
                    .frame(width: 68, height: 80)
                    .padding(.bottom, 20)
                
                Text("환영해요 \(user.nickEnglish)!")
                    .font(.system(size: 17, weight: .bold))
                    .padding(.bottom, 20)
                
                Text("오늘부터")
                    .font(.system(size: 15, weight: .medium))
                + Text(" 포켓러너 ")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(mainAccentColor)
                + Text("에서")
                    .font(.system(size: 15, weight: .medium))
                Text("나의 동료를 수집하고, 다른 러너들을")
                    .font(.system(size: 15, weight: .medium))
                Text("더 잘 이해하는 경험을 쌓아보세요!")
                    .font(.system(size: 15, weight: .medium))
                
                Button(action: {
                    onButtonTapped()
                }){
                    Text("포켓러너 시작하기")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(mainAccentColor)
                }.padding(.vertical, 20)
            }
        }
    }
}


