//
//  MainView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/11.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var user : userData
    
    var body: some View {
        AppleLoginView()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
