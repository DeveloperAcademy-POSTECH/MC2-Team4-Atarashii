//
//  MyCardView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI


struct MyCardView: View {
    @EnvironmentObject var user: userData
    @EnvironmentObject var card: CardDetailData
    
    @State var isMine: Bool = true
    @State var QRAnimation: Bool = false
    @Binding var isQRCodePresented: Bool
    
    @State private var blinkingAnimation = false
    
    @State var dummybookmarkIDs: [String] = []
    
    // myInfo 초기화.. with dummy data
    @State var myInfo: UserInfo = UserInfo(id: "", nickKorean: "", nickEnglish: "", isSessionMorning: true, introduce: "", skills: [], skillLevel: [], introduceSkill: "", growthTarget: "", wishSkills: [], wishSkillIntroduce: "", communicationType: 0, cooperationKeywords: [], cooperationIntroduce: "", cardColor: 0, cardPattern: 0, memoji: "")
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 40)
                
                // MARK: - 내 명함으로 이동하는 단일 카드 뷰
                CardTemplate(isMine: $isMine, isQRCodePresented: $isQRCodePresented, QRAnimation: $QRAnimation, learnerInfo: myInfo, bookmarkIDs: $dummybookmarkIDs)
                    .padding(.bottom, 34)
                
                // MARK: - 스와이프 안내 문구
                if !isQRCodePresented{
                    HStack {
                        Text("명함을 Swipe 해서 뒷면을 볼 수 있어요! →")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .opacity(blinkingAnimation ? 1.0 : 0.0)
                            .animation(Animation.easeIn(duration: 1).repeatForever(autoreverses: true))
                            .onAppear {
                                withAnimation {
                                    blinkingAnimation = true
                                }
                            }
                        Spacer()
                    }
                }
            }
            .padding(.top, -39)
            
            if isQRCodePresented{
                // MARK: - QR코드 뷰
                QRCodeGenerateView(isQRCodePresented: $isQRCodePresented, QRAnimation: $QRAnimation)
            }
        }
    }
}


//
//struct MyCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyCardView()
//    }
//}
