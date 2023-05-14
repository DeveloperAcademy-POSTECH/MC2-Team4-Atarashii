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
    
    @State var myInfo: UserInfo = UserInfo(id: "", nickKorean: "", nickEnglish: "", isSessionMorning: true, introduce: "", skills: [], skillLevel: [], introduceSkill: "", growthTarget: "", wishSkills: [], wishSkillIntroduce: "", communicationType: 0, cooperationKeywords: [], cooperationIntroduce: "", cardColor: 0, cardPattern: 0, memoji: "")
    
    var body: some Scene {
        WindowGroup {
            SelectMySkillView()
       //     MainView().environmentObject(user).environmentObject(card)
//            EditCardDesignView(userInfo: myInfo)

        }
    }
}
