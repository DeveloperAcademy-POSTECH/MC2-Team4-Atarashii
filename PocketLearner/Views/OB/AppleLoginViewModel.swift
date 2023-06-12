//
//  AppleLoginViewModel.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/11.
//

import SwiftUI
import CryptoKit
import AuthenticationServices
import Firebase

class AppleLoginViewModel: ObservableObject{
    @EnvironmentObject var user: userData
    
    // State of Signed in
    enum SignInState {
        case signedIn
        case signedOut
    }
    @Published var state: SignInState = .signedOut
    
    // LoginView - func configure
    @Published var nonce = ""
    
    func authenticate(credential: ASAuthorizationAppleIDCredential, failHandler : @escaping (String,String) -> Void ){
        
        print("authenticate 시작")
        // get Token
        guard let token = credential.identityToken else{
            print("Error with Firebase - Apple Login : GETTING TOKEN")
            failHandler("토큰 획득 실패!","다시 시도해주세요")
            return
        }
        
        // Token String
        guard let tokenString = String(data: token, encoding: .utf8) else{
            print("Error with Firebase - Apple Login : In Token Parsing to String")
            failHandler("토큰 파싱 실패!","다시 시도해주세요")
            return
        }
        
        // authorization Code to Unregister! => get user authorizationCode when login.
        if let authorizationCode = credential.authorizationCode, let codeString = String(data: authorizationCode, encoding: .utf8) {
            print("authorizationCode :: ", codeString)
            let url = URL(string: "https://us-central1-atarashii2-fa9ec.cloudfunctions.net/getRefreshToken?code=\(codeString)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "https://apple.com")!
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                if let data = data {
                    let refreshToken = String(data: data, encoding: .utf8) ?? ""
                    print("refreshToken :: ", refreshToken)
                    // TODO: *For security reasons, we recommend iCloud keychain rather than UserDefaults.
                    UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                    UserDefaults.standard.synchronize()
                }
                if let error = error {
                    print("Error on get Refresh Token :: \(error)")
                }
            }
            task.resume()
        }
        
        // Initialize a Firebase credential.
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        // Sign in with Firebase.
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            if let error = err {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(error.localizedDescription)
                failHandler("Auth 인증 실패","다시 시도해주세요")
                return
            }
            // User is signed in to Firebase with Apple.
            // ...
            print("Firebase - Apple Login : Logged In Successfully")
            
            //            UtilFunction.setPostSns(sns: true)
            
            // 로그인 후처리 - 회원가입 창으로 넘기기 or 로그인 시 앱 실행
            // 애플 로그인은 최초 회원가입 이후 user Email을 제공하지 않으므로, 유저 고유 key를 가지고 접근해야 함.
            let userID : String = credential.user
            let useremail : String = credential.email ?? ""
            
            
            
            if (useremail != ""){ //최초 register
                print("Sign in With Apple : Register, upload User Data on Firestore")
                db.collection("Users").document(useremail).setData([
                    "id" : useremail,
                    "AppleID" : userID,
                ], merge: true){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        failHandler("키페어 저장 실패","다시시도해주세요")
                    } else {
                        print("Document successfully written!")
                        self.findUserHandler(userID, failHandler)
                    }
                }
            }else{ //최초 register가 아닌 경우
                self.findUserHandler(userID, failHandler)
            }
        }
    }
    
    func findUserHandler(_ userID : String, _ failHandler : @escaping (String,String) -> Void){
        print("user 검색. \(userID)")
        db.collection("Users").whereField("AppleID", isEqualTo: userID)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    failHandler("유저 확인 실패","다시 시도해주세요")
                } else {
                    // 최초 등록이 되지 않은 경우
                    if(querySnapshot!.isEmpty){
                        failHandler("최초 등록 실패","관리자 문의 바랍니다")
                    }else{
                        for document in querySnapshot!.documents {
                            let useremail = document.data()["id"] as? String ?? ""
                            print("Success fetching Email Data from Firebase in Apple Login")
                            self.appleLoginHandler(true, useremail, failHandler: failHandler)
                        }
                    }
                }
            }
    }
    
    func appleLoginHandler(_ result : Bool ,_ useremail : String, failHandler : @escaping (String,String) -> Void){
        // 애플로그인
        print("User Data Fetching - appleLoginHandler : \(useremail)")
        let usersRef = db.collection("Users").document(useremail)
        usersRef.getDocument { (snap, err) in
            
            if let snap = snap, snap.exists {
                if let err = err {
                    print(err.localizedDescription)
                    failHandler("유저 정보 조회 실패", "다시 시도해주세요")
                    return
                }
                guard let dict = snap.data() else { return }
                let userItems = dict
                
                let AppldID = userItems["AppleID"] as? String ?? ""
                let id = userItems["id"] as? String ?? ""
                let nickEnglish = userItems["nickEnglish"] as? String ?? ""
                let nickKorean = userItems["nickKorean"] as? String ?? ""
                let isSessionMorning : Bool? = userItems["isSessionMorning"] as? Bool
                let cardCollectCount : Int = userItems["cardCollectCount"] as? Int ?? 0
                
                UserDefaults().set(id, forKey: "id")
                UserDefaults().set(AppldID, forKey: "AppleID")
                UserDefaults().set(nickEnglish, forKey: "nickEnglish")
                UserDefaults().set(nickKorean, forKey: "nickKorean")
                UserDefaults().set(isSessionMorning, forKey: "isSessionMorning")
                UserDefaults().set(cardCollectCount, forKey: "cardCollectCount")
                
                print("Uset Data Fetched, saved at UserDefaults.")
                
                //                    let readnick = userItems["nickname"] as? String ?? ""
                //                    let readcereal = userItems["cerealnum"] as? Int ?? 0
                //                    let tuto1 =  userItems["tuto1"] as? Bool ?? false
                //                    let tuto2 =  userItems["tuto2"] as? Bool ?? false
                //                    let tuto3 =  userItems["tuto3"] as? Bool ?? false
                //                    let friendCode = userItems["friendCode"] as? String ?? ""
                //                    let di =  userItems["di"] as? String ?? ""
                //                    let birth =  userItems["birthdate"] as? String ?? ""
                //                    var authed : Int = 0
                //                    authed = 0
                //                    if di != "" && birth != "" {
                //                        let yearStartIndex = birth.index(birth.startIndex, offsetBy: 0)
                //                        let yearEndIndex = birth.index(birth.startIndex, offsetBy: 3)
                //
                //                        let monthStartIndex = birth.index(birth.startIndex, offsetBy: 4)
                //                        let monthEndIndex = birth.index(birth.startIndex, offsetBy: 5)
                //
                //                        let dayStartIndex = birth.index(birth.startIndex, offsetBy: 6)
                //                        let dayEndIndex = birth.index(birth.startIndex, offsetBy: 7)
                //
                //                        let year : Int = Int(birth[yearStartIndex...yearEndIndex]) ?? 0
                //                        let month : Int = Int(birth[monthStartIndex...monthEndIndex]) ?? 0
                //                        let day : Int = Int(birth[dayStartIndex...dayEndIndex]) ?? 0
                //
                //                        let dateComp = DateComponents(year: year, month: month, day: day)
                //                        let birthDate = Calendar.current.date(from: dateComp)
                //                        let today = Date()
                //                        if birthDate != nil {
                //                            let betweenYear = Calendar.current.dateComponents([.year], from: birthDate!, to: today).year
                //                            let yearOld : Int = Int(betweenYear ?? 0)
                //
                //                            if yearOld > 18 { //18세 이상인 경우에만
                //                                authed = 1
                //                            }else{
                //                                authed = 2
                //                            }
                //                        }
                //                    }
                //                    if readnick != "" { // 회원가입 Form을 작성한 경우
                //                        if readcereal != 0 {
                //                            //Status 적용
                //                            UtilFunction.statusChangeToOnline(email: useremail)
                //                            UtilFunction.setPostID(id: useremail)
                //                            UtilFunction.setPostNick(nick: readnick)
                //                            UtilFunction.setPostCereal(cereal: readcereal)
                //                            UtilFunction.setPostFriendCode(friendCode: friendCode)
                //                            UtilFunction.setPostTuto1(tuto1: tuto1)
                //                            UtilFunction.setPostTuto2(tuto2: tuto2)
                //                            UtilFunction.setPostTuto3(tuto3: tuto3)
                //                            UtilFunction.setPostStatus(status: 2)
                //                            UtilFunction.setPostLoading(loading: false)
                //                            UtilFunction.setPostNiceAuthed(niceAuthed: authed)
                //                        }else{
                //                            UtilFunction.setPostID(id: useremail)
                //                            UtilFunction.setPostStatus(status: 1)
                //                            UtilFunction.setPostLoading(loading: false)
                //                        }
                //                    }else{
                //                        self.state = .signedIn
                //                        UtilFunction.setPostID(id: useremail)
                //                        UtilFunction.setPostStatus(status: 3)
                //                        UtilFunction.setPostLoading(loading: false)
                //                    }
                //Push토큰 저장
                //                    let token = UtilFunction.getPostedToken()
                //                    usersRef.setData(["token" : token], merge: true)
                //Notification On
                //                    UIApplication.shared.registerForRemoteNotifications(); print("Push notification on")
                //                    UserDefaults.standard.set(true, forKey: "push_notification")
                
            }
        }
    }
    
}





func afterLogin() async {
    
}

// From Firebase Official Document...
// Helpers for Apple Login with Firebase

func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()
    
    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}
