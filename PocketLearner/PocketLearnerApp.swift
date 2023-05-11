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
    
    var body: some Scene {
        WindowGroup {
            EditCardDesignView(userInfo: UserInfo(id: "", nicknameKOR: "리앤", nicknameENG: "Lianne", isMorningSession: true, selfDescription: "다재다능한 디발자가 꿈⭐️🐠🐶 개자이너 아니고 디발자요!", cardColor: "mainPurple"))
        }
    }
}
