//
//  MainTabView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/09.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        NavigationStack {
            TabView {
                // MARK: - 명함 탭 연결
                MainNameCardTabView()
                    .tabItem {
                        Image(systemName: "person.text.rectangle")
                        Text("First")
                    }
                
                // MARK: - 팀 탭 연결
                /// TODO: 팀 탭 생성 및 연결
                MainNameCardTabView()
                    .tabItem {
                        Image(systemName: "person.3.sequence")
                        Text("Second")
                    }
            }
        }
    }
    
    
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}





