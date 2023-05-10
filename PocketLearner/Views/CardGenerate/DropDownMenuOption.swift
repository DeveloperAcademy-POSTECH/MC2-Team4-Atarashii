//
//  DropDownMenuOption.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/10.
//

import SwiftUI

// SelectRoleGoalView의 드롭다운 메뉴 선택 옵션들

struct DropdownMenuOption: Identifiable, Hashable {
    let id = UUID().uuidString
    let option : String
}

extension DropdownMenuOption {
    static let testSingleChoice : DropdownMenuOption = DropdownMenuOption(option: "PM")
    static let testAllChoices: [DropdownMenuOption] = [
        DropdownMenuOption(option: "PM"),
        DropdownMenuOption(option: "iOS 개발자"),
        DropdownMenuOption(option: "서버 개발자"),
        DropdownMenuOption(option: "UI/UX 디자이너"),
        DropdownMenuOption(option: "직접 입력")
    ]
}
