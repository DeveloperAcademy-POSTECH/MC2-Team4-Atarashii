//
//  DropdownMenuListRow.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/10.
//

import SwiftUI

struct DropdownMenuListRow: View {
    let option: DropdownMenuOption
    var body: some View {
        Button(action: {}){
            Text(option.option)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.black)
                .padding(.vertical, 15)
                .padding(.leading, 17)
                .frame(maxWidth: 155, alignment: .leading)
                .background(
                    Rectangle()
                        .fill(.clear)
                )
        }
       
    }
}

struct DropdownMenuListRow_Previews: PreviewProvider {
    static var previews: some View {
        DropdownMenuListRow(option: DropdownMenuOption.testSingleChoice)
    }
}
