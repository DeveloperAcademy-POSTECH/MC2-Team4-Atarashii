//
//  CardDetailView.swift
//  bletest
//
//  Created by 이재원 on 2023/05/07.
//

import Foundation
import SwiftUI
import FirebaseStorage


struct CardDetailView: View{
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isMine: Bool
    let userInfo: UserInfo
    
    @EnvironmentObject var user: userData
    @EnvironmentObject var card: CardDetailData
    
    @State var introduceText: String = ""
    @State var introduceText2: String = ""
    @State var introduceText3: String = "iOS 개발자"

    
    @State var isHardSkillSet: Bool = true
    @State var isHardSkillSet_Button: Bool = true
    
    @State var retrievedImage = UIImage()
    
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
                        Spacer().frame(height: 150)
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
                                        .multilineTextAlignment(.center)
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
                self.introduceText = isMine ?  card.introduceSkill : userInfo.introduceSkill
                self.introduceText2 = isMine ? card.wishSkillIntroduce : userInfo.wishSkillIntroduce
                self.introduceText3 = isMine ? card.growthTarget : userInfo.growthTarget
                self.collaboraionIndexArr = indicesOfTrueValues(in: isMine ? card.cooperationKeywords : userInfo.cooperationKeywords)
                getPhotos()
            }
    }
    
    func getPhotos() {
        if isMine{
            // Get the data from the database
            let docRef = db.collection("CardDetails").document(user.id)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let imagePath = document.get("memoji")
                    print("CARDFRONT_IMAGEPATH: ", imagePath ?? "")
                    
                    // Get a reference to storage
                    let storageRef = Storage.storage().reference()
                    
                    // Specify the path
                    let fileRef = storageRef.child(imagePath as! String)
                    
                    // Retrieve the data
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        // Check for errors
                        if error == nil && data != nil {
                            // Create a UIImage and put it into display
                            if let image = UIImage(data: data!) {
                                DispatchQueue.main.async {
                                    retrievedImage = image
                                }
                            }
                        }
                    }
                } else {
                    print("Document does not exist")
                }
            }
        } else {
            // Get the data from the database
//            let docRef = Firestore.firestore().collection("CardDetails").document(learnerInfo.id)
            let imagePath = userInfo.memoji
            print("CARDFRONT_IMAGEPATH: ", imagePath)
            
            // Get a reference to storage
            let storageRef = Storage.storage().reference()
            
            // Specify the path
            let fileRef = storageRef.child(imagePath)
            
            // Retrieve the data
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                // Check for errors
                if error == nil && data != nil {
                    // Create a UIImage and put it into display
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            retrievedImage = image
                        }
                    }
                }
            }
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
        VStack {
            Text("나는 아카데미에서의 협업을 통해")
                .font(.system(size: 16, weight: .regular))
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            HStack{
                Text(introduceText)
                    .bold()
                    .font(.system(size: 15))
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(mainOrengeColor,lineWidth: 2)
                    )
                Text(" 로서 성장하고 싶어요")
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 2)
            }
        }.padding(.horizontal, 20).padding(.bottom, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
        ).padding(.horizontal, 20)
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
    
    
    /// profile Image(Memoji) with Circle
    /// 190 x 190 pixel.
    func profileCircle(isMorning: Bool) -> some View{
        ZStack {
            Image(uiImage: retrievedImage)
                .resizable()
                .frame(width: 180, height: 180)
                .aspectRatio(contentMode: .fill)
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
                .padding(.top, 170)
        }
    }
    
    
    
}
