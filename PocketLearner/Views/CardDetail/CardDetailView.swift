//
//  CardDetailView.swift
//  bletest
//
//  Created by 이재원 on 2023/05/07.
//

import Foundation
import SwiftUI

struct CardDetailView: View{
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isMine: Bool
    let userInfo: UserInfo
    
    @EnvironmentObject var user: userData
    @EnvironmentObject var card: CardDetailData
    
    @State var introduceText: String = """
    Sketch보다는 Figma를 선호하는 취향이 확고한
    편이에요 :) 저는 디자인 업무를 주로 해봤기 때문
    에 디자인 툴 활용이 익숙하지만, iOS 개발자로서
    의 커리어를 좀 더 키우고 싶어요, UIKit은 이제 배
    우고 있는 단계이지만, SwiftUI는 나름 능숙하게
    다룰 수 있답니다!
    """
    @State var introduceText2: String = """
    개발공부를 시작한지 얼마 안되기도 했고, 다른 개
    발자와 협업해 본 적이 없어서 Git CLI가 익숙하지
    않아요! 같이 Git 공부할 사람?
    """
    @State var introduceText3: String = "iOS 개발자"
    
    @State var isHardSkillSet: Bool = true
    @State var isHardSkillSet_Button: Bool = true
    
    let fourTypeCardsDatas : [FourTypeCardData] = [
        FourTypeCardData(title: "Analytical", englishDescription: "Fact-Based Introvert", description: "결과보다는 관계와 과정을,\n리스크 보다는 안정감을 중요시해요.", imageTitle: "analyticalCardImage"),
        FourTypeCardData(title: "Driver", englishDescription: "Fact-Based Extrovert", description: "추진력이 좋고 결과를 중시해요\n업무에서의 효율성을 추구해요.", imageTitle: "driverCardImage"),
        FourTypeCardData(title: "Amiable", englishDescription: "Relationship-Based Introvert", description: "팀원의 이야기를 경청하고 팔로우해요.\n변화보다는 안정감을 선호해요.", imageTitle: "amiableCardImage"),
        FourTypeCardData(title: "Expressive", englishDescription: "Relationship-Based Extrovert", description: "활발하게 소통하고, 창의적이에요\n팀원들간의 화합과 설득을 중시해요.", imageTitle: "expressiveCardImage")
    ]
    
    let collaboraionDatas: [CollaborationButtonData] = [
        CollaborationButtonData(buttonColor: collaborationKeywordColor_0, buttonTitle: "갈등중재"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_1, buttonTitle: "리더십"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_2, buttonTitle: "팔로워십"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_3, buttonTitle: "소통왕"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_4, buttonTitle: "감성지능"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_5, buttonTitle: "비판적\n사고"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_6, buttonTitle: "공감능력"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_7, buttonTitle: "유연한\n사고"),
    ]
    @State var collaboraionIndexArr: [Int] = []
    
    var body: some View{
        ScrollView {
            // curved rectangle, ignore safeArea to top.
            // (when user scroll to top, still can see the purple rectangle)
            ZStack (alignment: .top){
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(isMine ? cardColorList[card.cardColor]: cardColorList[userInfo.cardColor])
                    .frame(height: 800)
                    .offset(y: -386)
                Image(isMine ? cardPatternList[card.cardPattern]: cardPatternList[userInfo.cardPattern])
                    .resizable()
                    .frame(height: 800)
                    .offset(y: -386)
                    
                    
                VStack {
                    Group {
                        backHeader()
                        Spacer().frame(height: 70)
                        VStack{
                            Text("\(isMine ? user.nickEnglish:userInfo.nickEnglish)")
                                .font(.system(size: 40, weight: .bold))
                                .scaleEffect(x: 1.2)
                        }
                        
                        Text("\(isMine ? user.nickKorean:userInfo.nickKorean)")
                            .font(.system(size: 22))
                            .padding(.top, -20)
                        Spacer().frame(height: 300)
                    }
                    Group {
                        Text("\(isMine ? card.introduce:userInfo.introduce)")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.center)
                            .frame(height: 80)
                        Spacer().frame(height: 30)
                        skillCooperationButton()
                        Spacer().frame(height: 60)
                    }
                    if isHardSkillSet{
                        HStack(spacing: 30) {
                            Image("mySkillKang")
                                .frame(width: 77,height: 95)
                            textMultipleColor_CanSkillSet(text1: "현재 이런 ", text2: "스킬셋", text3: "을", text4: "활용할 수 있어요!")
                        }
                        .padding(.top, -20)
                        SkillSetHorizontalScrollView(skills: isMine ? card.skills: userInfo.skills, skillCounts: isMine ? card.skillLevel: userInfo.skillLevel)
                            .padding(.top,-20)
                        grayBackgroundIntroduceTextBox(introduceText: introduceText)
                        HStack(spacing: 30) {
                            Image("WishSkillKang")
                                .frame(width: 77,height: 95)
                            textMultipleColor_CanSkillSet(text1: "앞으로 이런 ", text2: "스킬셋", text3: "을", text4: "키우고 싶어요!")
                        }
                        .padding()
                        WishSkillSetHorizontalScrollView(skills: isMine ? card.wishSkills:userInfo.wishSkills)
                            .padding(.top,-20)
                        grayBackgroundIntroduceTextBox(introduceText: introduceText2)
                        HStack(spacing: 30) {
                            Image("MyGoalKang")
                                .frame(width: 77,height: 95)
                            textMultipleColor_CanSkillSet(text1: "아카 ", text2: "데미", text3: "에서의", text4: "성장 목표!")
                        }
                        .padding()
                        whiteBackgroundIntroduceTextBox(introduceText: introduceText3)
                        
                    }
                    else {
                        textMultipleColor_CanSkillSet2(text1: "제 ", text2: "커뮤니케이션", text3: " 타입", text4: "은")
                            .padding()
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 65, style: .continuous)
                                .fill(Color.white)
                                .frame(width: 300, height: 300)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                            VStack{
                                Image("\(fourTypeCardsDatas[isMine ? card.communicationType:userInfo.communicationType].imageTitle)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                                Text("\(fourTypeCardsDatas[isMine ? card.communicationType:userInfo.communicationType].title)")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.top, 20)
                                    .padding(.bottom, 10)
                                Text("\(fourTypeCardsDatas[isMine ? card.communicationType:userInfo.communicationType].description)")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        Text("저와 어울리는 협업 키워드는")
                            .font(.system(size: 22, weight: .bold))
                            .padding(.top, 70)
                            .padding(.bottom, 30)
                        HStack{
                            let skills = [("\(collaboraionDatas[collaboraionIndexArr[0]].buttonTitle)", collaboraionDatas[collaboraionIndexArr[0]].buttonColor), ("\(collaboraionDatas[collaboraionIndexArr[1]].buttonTitle)", collaboraionDatas[collaboraionIndexArr[1]].buttonColor), ("\(collaboraionDatas[collaboraionIndexArr[2]].buttonTitle)", collaboraionDatas[collaboraionIndexArr[2]].buttonColor)]
                            
                            ForEach(skills.indices) { index in
                                let skill = skills[index]
                                ZStack {
                                    Circle()
                                        .stroke(skill.1, lineWidth: 3)
                                        .frame(width: 100, height: 100)
                                    Text(skill.0)
                                        .foregroundColor(skill.1)
                                        .font(.system(size: 20, weight: .bold))
                                }.padding(.horizontal, 10)
                            }
                        }.padding(.bottom, 50)
                        grayBackgroundIntroduceTextBox(introduceText: introduceText)
                    }
                }
                VStack{
                    profileCircle(isMorning: isMine ? user.isSessionMorning: userInfo.isSessionMorning)
                        .padding(.top, 300)
                }
            }
            VStack {
                Spacer().frame(height: 95)
            }
            
        }.ignoresSafeArea().frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear() {
//                if isMine {
//                    let mine: UserInfo = UserInfo(id: user.id, nickKorean: user.nickKorean, nickEnglish: user.nickEnglish, isSessionMorning: user.isSessionMorning, introduce: card.introduce, skills: card.skills, skillLevel: card.skillLevel, introduceSkill: card.introduceSkill, growthTarget: card.growthTarget, wishSkills: card.wishSkills, wishSkillIntroduce: card.wishSkillIntroduce , communicationType: card.communicationType , cooperationKeywords: card.cooperationKeywords , cooperationIntroduce: card.cooperationIntroduce, cardColor: card.cardColor, cardPattern: card.cardPattern , memoji: card.memoji )
//                    userInfo = mine
//                }
                self.introduceText = isMine ?  card.introduceSkill : userInfo.introduceSkill
                self.introduceText2 = isMine ? card.wishSkillIntroduce : userInfo.wishSkillIntroduce
                self.introduceText3 = isMine ? card.growthTarget : userInfo.growthTarget
                self.collaboraionIndexArr = indicesOfTrueValues(in: isMine ? card.cooperationKeywords : userInfo.cooperationKeywords)
            }
    }
    
    
    func indicesOfTrueValues(in array: [Bool]) -> [Int] {
        return array.enumerated().compactMap { index, value in
            value ? index : nil
        }
    }
    
    func grayBackgroundIntroduceTextBox(introduceText: String) -> some View{
        Text(introduceText)
            .frame(minWidth: 320)
            .font(.system(size: 16, weight: .regular))
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 20)
            .lineSpacing(7)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(textBackgroundGrayColor)
            )
    }
    
    func whiteBackgroundIntroduceTextBox(introduceText: String) -> some View{
        ZStack {
            Text("나는 아카데미에서의 협업을 통해                         \n                            로서 성장하고 싶어요")
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
                .lineSpacing(7)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 5)
                )
            Text(introduceText)
                .bold()
                .font(.system(size: 15))
                .padding([.horizontal,.vertical],5)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(mainOrengeColor,lineWidth: 2)
                )
                .padding(.leading,-120)
                .padding(.top,27)
        }
    }
    
    func textMultipleColor_CanSkillSet(text1:String,text2:String,text3:String,text4:String) -> some View{
        VStack{
            Text(text1)
                .foregroundColor(.black)
                .font(.system(size: 21, weight: .bold))
            + Text(text2)
                .foregroundColor(.black)
                .font(.system(size: 21, weight: .bold))
            + Text(text3)
                .foregroundColor(.black)
                .font(.system(size: 21, weight: .bold))
            Text(text4)
                .foregroundColor(mainOrengeColor)
                .font(.system(size: 21, weight: .bold))
        }.fixedSize(horizontal: false, vertical: true)
    }
    func textMultipleColor_CanSkillSet2 (text1:String,text2:String,text3:String,text4:String) -> some View{
        VStack{
            Text(text1)
                .foregroundColor(.black)
                .font(.system(size: 21, weight: .bold))
            + Text(text2)
                .foregroundColor(mainOrengeColor)
                .font(.system(size: 21, weight: .bold))
            + Text(text3)
                .foregroundColor(mainOrengeColor)
                .font(.system(size: 21, weight: .bold))
            + Text(text4)
                .foregroundColor(.black)
                .font(.system(size: 21, weight: .bold))
        }.fixedSize(horizontal: false, vertical: true)
    }
    
    /// 눌렀을 때 Opacity가 변하지 않는 ButtonStyle 재정의
    struct buttonStyleNotOpacityChange: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
    
    
    func skillCooperationButton() -> some View {
        return Button(action: {
            withAnimation(.easeOut(duration: 0.3)){
                isHardSkillSet_Button.toggle()
            }
            withAnimation(.easeOut(duration: 0.6)){
                isHardSkillSet.toggle()
            }
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 200, style: .continuous)
                    .fill(hexStringToColor(hexString: "#F3F3F3"))
                    .frame(width: 300, height: 45)
                RoundedRectangle(cornerRadius: 200, style: .continuous)
                    .fill(mainOrengeColor)
                    .frame(width: 150, height: 37)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .offset(x: isHardSkillSet_Button ? -71 : 71)
                Text("스킬")
                    .font(.system(size: 15, weight: isHardSkillSet_Button ? .bold : .regular))
                    .offset(x: -71)
                Text("협업")
                    .font(.system(size: 15, weight: isHardSkillSet_Button ? .regular : .bold))
                    .offset(x: 71)
            }.frame(width: 300, height: 45)
        }).buttonStyle(buttonStyleNotOpacityChange())
    }
    
    /// header with "only" back button
    func backHeader() -> some View {
        return HStack{
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
            }).padding(.leading, 20)
            Spacer()
        }.padding(.top, 50)
    }
    
    /// profile Image(Memoji) with Circle
    /// 190 x 190 pixel.
    func profileCircle(isMorning: Bool) -> some View{
        ZStack {
            Image("dummypikachu")
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 130)
                .offset(x:5, y: 4)
                .padding(30)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(mainOrengeColor, lineWidth: 3.84)
                )
            
            Text(isMorning ? "🌞 오전":"🌝 오후")
                .frame(maxWidth: 69,maxHeight: 28)
                .background(
                    RoundedRectangle(cornerRadius: 22)
                        .fill(.white)
//                        .stroke()
                )
                .padding(.top, 185)
        }
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardDetailView().previewDevice("iPhone 14")
//    }
//}
