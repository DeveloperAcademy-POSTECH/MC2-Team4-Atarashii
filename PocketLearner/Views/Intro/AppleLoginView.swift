//
//  AppleLoginView.swift
//  bletest
//
//  Created by 주환 on 2023/05/08.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices

struct AppleLoginView : View {
    @State var currentNonce: String?
    var body: some View {
        VStack {
            
            Text("안녕하세요!\n애플 디벨로퍼 아카데미 \n버츄얼 명함 서비스\n00 입니다.")
                .bold()
                .lineSpacing(CGFloat(20))
                .font(.system(size: 25.63))
                .frame(width: 276,height: 200)
                .padding()
//                .background(Color.blue)
            
            SignInWithAppleButton(onRequest: { request in
                let nonce = AuthService.shard.randomNonceString()
                currentNonce = nonce
                request.requestedScopes = [.fullName, .email]
                request.nonce = AuthService.shard.sha256(nonce)
            }, onCompletion: AuthService.shard.handleAppleSignIn
            )
            .signInWithAppleButtonStyle(.black)
            .frame(width: 285, height: 60)
            .padding(.top,300)
        }
    }
    
}


struct AppleLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AppleLoginView().previewDevice("iPhone 14")
    }
}
