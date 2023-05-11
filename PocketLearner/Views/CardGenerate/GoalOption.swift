//
//  GoalOption.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/10.
//

import Foundation

struct GoalOption: Identifiable {
    let id = UUID().uuidString
    let title: String
}

extension GoalOption {
    static let list: [GoalOption] = [
        GoalOption(title: "PM"),
        GoalOption(title: "iOS 개발자"),
        GoalOption(title: "서버 개발자"),
        GoalOption(title: "UI/UX 디자이너"),
        GoalOption(title: "직접 입력")
    ]
}
