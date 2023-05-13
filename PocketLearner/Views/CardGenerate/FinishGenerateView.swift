//
//  FinishGenerateView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/13.
//

import SwiftUI

struct FinishGenerateView: View {
    @EnvironmentObject var user: userData
    @ObservedObject var card: CardDetailData
    @State var isErrorAppeared: Bool = false

    var body: some View {
        VStack{
            if (isErrorAppeared){
                Text("명함 생성 중 오류가 발생했습니다.\n인터넷 연결을 확인하고, 다시 시도해주세요.")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.black)
                cardGenerateViewsButton(title: "다시 생성 시도", disableCondition: false, action: {
                    generateCardData()
                })
            } else {
                Text("수고하셨습니다!\n이제 다른 사람과 명함을 교환해 보세요!")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.black)
                cardGenerateViewsButton(title: "다음", disableCondition: false, action: {
                    UtilFunction.popToRootView()
                })
            }
        }.task {
            generateCardData()
        }
    }
    
    func generateCardData(){
        db.collection("CardDetails").document(user.id).setData([
            "id": user.id,
            "nickEnglish": user.nickEnglish,
            "nickKorean": user.nickKorean,
            "isSessionMorning": user.isSessionMorning,
            "introduce": card.introduce,
            "skills": card.skills,
            "skillLevel": card.skillLevel,
            "introduceSkill": card.introduceSkill,
            "growthTarget": card.growthTarget,
            "wishSkills": card.wishSkills,
            "wishSkillIntroduce": card.wishSkillIntroduce,
            "communicationType": card.communicationType,
            "cooperationKeywords": card.cooperationKeywords,
            "cooperationIntroduce": card.cooperationIntroduce,
            "cardColor": card.cardColor,
            "cardPattern": card.cardPattern,
            "memoji": card.memoji
        ]){ err in
            if let err = err {
                isErrorAppeared = true
            } else {
                isErrorAppeared = false
            }
        }
    }
}
