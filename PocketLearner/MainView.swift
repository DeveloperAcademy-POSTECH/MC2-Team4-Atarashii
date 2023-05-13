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
        if user.AppleID == "" {
            AppleLoginView()
        } else if user.nickEnglish == "" {
            // 닉네임 설정 후 세션 설정을 했더라도, 그냥 다시 닉네임 설정 뷰로 돌아오게 함.
            CreateNickNameView()
        } else {
            MainTabView().environmentObject(user)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
