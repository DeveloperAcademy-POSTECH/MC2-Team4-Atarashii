//
//  TestView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/08/10.
//

import SwiftUI

struct TestView: View {
    
    let text = "안녕하세요\n안녕안녕"
    var body: some View {
        List {
            Text(text)
                .font(Font.largeTitleFont())
                .foregroundColor(Color.cpBlue)
                .multilineTextAlignment(.leading)
            Text(text)
                .font(Font.titleFont())
                .multilineTextAlignment(.leading)
            Text(text)
                .font(Font.extraBodyFont())
                .multilineTextAlignment(.leading)
            Text(text)
                .font(Font.semiBodyFont())
                .multilineTextAlignment(.leading)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
