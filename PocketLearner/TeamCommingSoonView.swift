//
//  TeamCommingSoonView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/15.
//

import SwiftUI

struct TeamCommingSoonView: View {
    let deepOrange = Color(#colorLiteral(red: 1, green: 0.3725490196, blue: 0.1411764706, alpha: 1))
    var body: some View {
        ZStack(alignment: .top) {
            Image("kangaroo_body")
                    .offset(y: -120)
                ZStack(alignment: .leading){ // 카드 뷰
                    RoundedRectangle(cornerRadius: 32)
                        .fill(.white)
                        .frame(width: 315, height: 490)
                        .shadow(color: .black.opacity(0.08), radius: 24, x: 0, y: 4)
                    VStack(alignment: .leading, spacing: 0){
                        Text("아따라시팀은 공사중!👷🏻")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(deepOrange)
                        Text("이 기능은 아직\n준비중이에요!\n조금만 기다려주세요 :)")
                            .font(.system(size: 25, weight: .medium))
                            .foregroundColor(errorGray)
                            .padding(.top, 62)
                            .lineSpacing(12)
                    }
                    .padding(.leading, 30)
                }
                Image("kangaroo_arm")
                    .offset(y: -17)
            }
        .padding(.top, 177-118)
    }
}

struct TeamCommingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        TeamCommingSoonView()
    }
}
