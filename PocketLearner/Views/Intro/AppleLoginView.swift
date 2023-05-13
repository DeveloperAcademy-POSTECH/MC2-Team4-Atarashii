//
//  AppleLoginView.swift
//  bletest
//
//  Created by 주환 on 2023/05/08.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices
import Firebase

// AppleUser 객체를 Codable로 설정하여
// Encoding, Decoding이 가능 => UserDefault에 저장이 가능한 형태로.
struct AppleUser: Codable {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential){
        guard
            let firstName = credentials.fullName?.givenName,
            let lastName = credentials.fullName?.familyName,
            let email = credentials.email
        else{return nil}
        
        self.userId = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

struct AppleLoginView : View {
    @EnvironmentObject var user: userData
    @EnvironmentObject var card: CardDetailData
    @StateObject var loginData = AppleLoginViewModel()
    
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
            
            //            SignInWithAppleButton(onRequest: { request in
            //                let nonce = AuthService.shard.randomNonceString()
            //                currentNonce = nonce
            //                request.requestedScopes = [.fullName, .email]
            //                request.nonce = AuthService.shard.sha256(nonce)
            //            }, onCompletion: AuthService.shard.handleAppleSignIn
            //            )
            
            SignInWithAppleButton(
                onRequest: configure,
                onCompletion: handle)
            .frame(width: 285, height: 60)
            .padding(.top,300)
        }
    }
    
    func failHandler(errString1:String, errString2:String){
        print("error on apple login: \(errString1), \(errString2)")
    }
    
    
    
    func configure(_ request: ASAuthorizationAppleIDRequest){
        loginData.nonce =  randomNonceString()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(loginData.nonce)
        //        let controller = ASAuthorizationController(authorizationRequests: [request])
        //        controller.performRequests()
    }
    
    func handle(_ authResult: Result<ASAuthorization, Error>){
        switch authResult{
        case .success(let auth):
            print(auth)
            switch auth.credential{
            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
                if let appleUser = AppleUser(credentials: appleIdCredentials){
                    // AppleUser 객체를 JSON 형태로 Encoding하여 UserDefaults에 저장할 수 았는 형태로.
                    let appleUserData = try? JSONEncoder().encode(appleUser)
                    // UserDefaults에 Register한 User의 정보 저장. 초회차 로그인(Register) 이후에는 유저 데이터에 접근할 수 없으므로
                    // 데이터를 유실하지 않도록 신중하게 관리하여 DB에 업로드해야 함.
                    // Data는 Encoding한 AppleUser 객체, key는 유일성을 보장할 수 있는 userId로 설정.
                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
                    
                    print(">>> Saved Apple User : ", appleUser)
                    
                    
                    
                } else {    // field 정보 부족으로 AppleUser 객체 생성 실패 시
                    print("missing some fields",
                          appleIdCredentials.email ?? "" ,
                          appleIdCredentials.fullName ?? "",
                          appleIdCredentials.user )
                }
                
                // ------ Firebase Login ------
                guard let credential = auth.credential as? ASAuthorizationAppleIDCredential
                else{print("Error with Firebase - Apple Login : GETTING CREDENTIAL")
                    return
                }
                loginData.authenticate(credential: credential, failHandler: failHandler)
                // ------ Firebase Login ------
                
                // if Firebase Login Successed.
                // MARK: AppleLoginViewModel - AppleLoginHandler쪽에 구현되어 있으나, userData(EnvironmentOB)를 업데이트하기 위함.
                user.AppleID = credential.user
                if let email = credential.email {
                    user.id = email
                    print("첫 로그인(회원가입) : \(user.id) email data saved.")
                } else {
                    db.collection("Users").whereField("AppleID", isEqualTo: user.AppleID)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents - AppleLoginView[handle] : \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    print("Document ID: \(document.documentID)")
                                    if let idField = document.get("id") as? String {
                                        user.id = idField
                                        print("로그인(이미 가입된 회원) : \(user.id) - email data saved.")
                                    }
                                    if let nickEnglish = document.get("nickEnglish") as? String {
                                        user.nickEnglish = nickEnglish
                                        print("로그인(이미 가입된 회원) : \(user.nickEnglish)")
                                    }
                                    if let nickKorean = document.get("nickKorean") as? String {
                                        user.nickKorean = nickKorean
                                        print("로그인(이미 가입된 회원) : \(user.nickKorean)")
                                    }
                                    if let isSessionMorning = document.get("isSessionMorning") as? Bool {
                                        user.isSessionMorning = isSessionMorning
                                        print("로그인(이미 가입된 회원) : \(user.isSessionMorning)")
                                    }
                                }
                            }
                        }
                    
                    let cardDetailDocRef = db.collection("CardDetails").document(user.id)
                }
                
            default:
                print(auth.credential)
            }
            
        case .failure(let err):
            print(">>> Handle Failure : ", err)
        }
    }
}


struct AppleLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AppleLoginView().previewDevice("iPhone 14")
    }
}
