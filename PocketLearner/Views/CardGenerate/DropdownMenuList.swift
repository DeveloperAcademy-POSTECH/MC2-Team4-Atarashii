//
//  DropdownMenuListView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/10.
//

import SwiftUI

struct DropdownMenuList: View {
    let options : [DropdownMenuOption]
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 2){
            ForEach(options) { option in
                DropdownMenuListRow(option: option)
            }
        }
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(menuDefaultGray)
                .frame(maxWidth: 155)
        }
    }
}


struct DropdownMenuList_Previews: PreviewProvider {
    static var previews: some View {
        DropdownMenuList(options: DropdownMenuOption.testAllChoices)
    }
}
