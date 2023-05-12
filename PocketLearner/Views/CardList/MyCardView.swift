//
//  MyCardView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI


struct MyCardView: View {
    
    @State var isMine: Bool = true
    
    @State var isQRCodePresented: Bool = false
    @State var QRAnimation: Bool = false
    
    // MARK: - 내 유저 정보 dummy 인스턴스
    let myInfo: UserInfo = UserInfo(id: "", nicknameKOR: "리앤", nicknameENG: "Lianne", isMorningSession: true, selfDescription: "다재다능한 디발자가 꿈⭐️🐠🐶 개자이너 아니고 디발자요!", cardColor: "mainPurple")
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                    .frame(height: 80)
                
                // MARK: - 내 명함으로 이동하는 단일 카드 뷰
                CardTemplate(isMine: $isMine, isQRCodePresented: $isQRCodePresented, QRAnimation: $QRAnimation, userInfo: myInfo)
                    .padding(.bottom, 34)
                
                // MARK: - 스와이프 안내 문구
                Text("명함을 Swipe 해서 뒷면을 볼 수 있어요!")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            if isQRCodePresented{
                // MARK: - QR코드 뷰
                QRCodeGenerateView(isQRCodePresented: $isQRCodePresented, QRAnimation: $QRAnimation)
            }
        }
    }
}



struct MyCardView_Previews: PreviewProvider {
    static var previews: some View {
        MyCardView()
    }
}
