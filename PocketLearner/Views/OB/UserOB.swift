//
//  UserOB.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/11.
//

import Foundation

class userData: ObservableObject {
    @Published var AppleID = UserDefaults().string(forKey: "AppleID") ?? ""
    @Published var id = UserDefaults().string(forKey: "id") ?? ""
    @Published var nickEnglish = UserDefaults().string(forKey: "nickEnglish") ?? ""
    @Published var nickKorean = UserDefaults().string(forKey: "nickKorean") ?? ""
    @Published var isSessionMorning = UserDefaults().bool(forKey: "isSessionMorning")
    
    @Published var phaseFlag :Bool = true
}
