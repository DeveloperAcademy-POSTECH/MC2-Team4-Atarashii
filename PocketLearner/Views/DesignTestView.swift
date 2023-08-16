//
//  DesignTestView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/08/16.
//

import SwiftUI

struct DesignTestView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).largeTitleFont()
                .foregroundColor(.cpBlue)
            Text("안녕안녕").buttonFont()
                .foregroundColor(.mainOrange)
            Text("안녕안녕").captionFont()
        }
    }
}

struct DesignTestView_Previews: PreviewProvider {
    static var previews: some View {
        DesignTestView()
    }
}
