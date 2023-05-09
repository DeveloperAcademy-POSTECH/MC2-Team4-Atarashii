//
//  MyCardView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI

struct MyCardView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 80)
            
            // MARK: - 내 명함으로 이동하는 단일 카드 뷰
            CardTemplate()
                .padding(.bottom, 34)
            
            // MARK: - 스와이프 안내 문구
            Text("명함을 Swipe 해서 뒷면을 볼 수 있어요!")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}



struct MyCardView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardView()
    }
}
