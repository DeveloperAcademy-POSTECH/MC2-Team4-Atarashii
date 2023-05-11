//
//  GoalPickerMenu.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/10.
//

import SwiftUI

struct GoalPickerMenuList: View {
    let list = GoalOption.list
    let sendAction: (_ option: GoalOption) -> Void
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 15){
            ForEach(list) { option in
                Button(action: {
                    sendAction(option)
                }){
                    Text(option.title)
                        .font(.system(size:15, weight: .regular))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment:.leading)
                }
            }
        }
        .padding(.leading, 17)
        .frame(height: 170)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(menuDefaultGray)
        }
    }
}

struct GoalPickerMenuList_Previews: PreviewProvider {
    static var previews: some View {
        GoalPickerMenuList(sendAction: {_ in })
    }
}
