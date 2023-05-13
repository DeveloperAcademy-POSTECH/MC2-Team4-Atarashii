//
//  PocketLearnerApp.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/09.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct PocketLearnerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var user = userData()
    @StateObject var card = CardDetailData()
    
    @State var a: Bool = true
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(user).environmentObject(card)
//            CardTemplate(isMine: $a, userInfo: UserInfo(id: "", nicknameKOR: "헤이즐", nicknameENG: "Hazel", isMorningSession: false, selfDescription: "올라운더 디자이너로 활약 중입니다!✨", cardColor: "mainGreen"))
//            MainNameCardTabView()
//            InitailCardMainView()

        }
    }
}
