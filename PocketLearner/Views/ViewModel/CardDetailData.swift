//
//  CardGenerateOB.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/13.
//

import Foundation

class CardDetailData: ObservableObject {
    @Published var introduce: String = ""
    @Published var skills: [String] = []
    @Published var skillLevel: [Int] = []
    @Published var introduceSkill: String = ""
    @Published var growthTarget: String = ""
    @Published var wishSkills: [String] = []
    @Published var wishSkillIntroduce: String = ""
    @Published var communicationType: Int = 0
    @Published var cooperationKeywords: [Bool] = []
    @Published var cooperationIntroduce: String = ""
    @Published var cardColor: Int = 0
    @Published var cardPattern: Int = 0
    @Published var memoji: String = ""
    
    @Published var id: String = ""
    @Published var nickEnglish: String = ""
    @Published var nickKorean: String = ""
    @Published var isSessionMorning: Bool = true
}
