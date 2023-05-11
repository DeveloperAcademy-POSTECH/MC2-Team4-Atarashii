////
////  AuthService.swift
////  bletest
////
////  Created by 주환 on 2023/05/08.
////
//
//import SwiftUI
//import AuthenticationServices
//import FirebaseAuth
//import CryptoKit
//
//struct AuthService {
//    static let shard = AuthService()
//
//    func randomNonceString(length: Int = 32) -> String {
//      precondition(length > 0)
//      let charset: Array<Character> =
//          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//      var result = ""
//      var remainingLength = length
//
//      while remainingLength > 0 {
//        let randoms: [UInt8] = (0 ..< 16).map { _ in
//          var random: UInt8 = 0
//          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
//          if errorCode != errSecSuccess {
//            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
//          }
//          return random
//        }
//
//        randoms.forEach { random in
//          if remainingLength == 0 {
//            return
//          }
//
//          if random < charset.count {
//            result.append(charset[Int(random)])
//            remainingLength -= 1
//          }
//        }
//      }
//
//      return result
//    }
//
//    @State var currentNonce:String?
//
//        //Hashing function using CryptoKit
//        func sha256(_ input: String) -> String {
//            let inputData = Data(input.utf8)
//            let hashedData = SHA256.hash(data: inputData)
//            let hashString = hashedData.compactMap {
//            return String(format: "%02x", $0)
//            }.joined()
//
//            return hashString
//        }
//
//    func handleAppleSignIn(result: Result<ASAuthorization, Error>) {
//        switch result {
//        case .success(let authResults):
//            switch authResults.credential {
//            case let appleIDCredential as ASAuthorizationAppleIDCredential:
//
//                guard let nonce = currentNonce else {
//                    // DEBUG: Error -> edit plz
//                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
//                }
//                guard let appleIDToken = appleIDCredential.identityToken else {
//                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
//                }
//                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//                    return
//                }
//
//                let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
//                Auth.auth().signIn(with: credential) { (authResult, error) in
//                    if (error != nil) {
//                        // Error. If error.code == .MissingOrInvalidNonce, make sure
//                        // you're sending the SHA256-hashed nonce as a hex string with
//                        // your request to Apple.
//                        print(error?.localizedDescription as Any)
//                        return
//                    }
//                    print("signed in")
//                }
//
//                print("\(String(describing: Auth.auth().currentUser?.uid))")
//            default:
//                break
//
//            }
//        default:
//            break
//        }
//    }
//}
//
//
//
