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
    
    // 컨텐츠 뷰를 리턴하는 함수.
    func returnfinishGenerateContent (title: String, description: String, buttonTitle: String, buttonAction: @escaping ()->Void, buttonColor: Color) -> some View {
        return VStack(alignment: .leading, spacing: 0){
            Text(title)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.black)
            Text(description)
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(errorGray)
                .padding(.top, 62)
            Button(action: {
                buttonAction()
            }){
                HStack(spacing: 5) {
                        Text(buttonTitle)
                        .font(.system(size: 16.54, weight: .medium))
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right")
                        .font(.system(size: 16.54, weight: .medium))
                            .foregroundColor(.white)
                }
                .padding(.vertical, 11)
                .padding(.horizontal, 18)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(buttonColor)

                )

            }
            .padding(.top, 40)
        }
        .padding(.leading, 38)
    }
    var body: some View {
            ZStack(alignment: .top) {
                Image(isErrorAppeared ? "kangaroo_body_error":"kangaroo_body")
                        .offset(y: -120)
                    ZStack(alignment: .leading){ // 카드 뷰
                        RoundedRectangle(cornerRadius: 32)
                            .fill(.white)
                            .frame(width: 315, height: 490)
                            .shadow(color: .black.opacity(0.08), radius: 24, x: 0, y: 4)
                        // Content - if문을 통한 분기
                        if (isErrorAppeared){
                            returnfinishGenerateContent (title: "명함 생성중 오류 발생!", description: "인터넷 연결을 확인하고,\n다시 시도해주세요.", buttonTitle: "다시 생성 시도", buttonAction: {
                                generateCardData()
                            }, buttonColor: errorGray)

                        } else {
                            returnfinishGenerateContent (title: "명함 생성 완료!", description: "이제 명함을 교환하고,\n수집해 보세요!", buttonTitle: "명함 수집하러 가기", buttonAction: {
                                UtilFunction.popToRootView()
                            }, buttonColor: mainAccentColor)
                        }// else
                    }
                    Image(isErrorAppeared ? "kangaroo_arm_error":"kangaroo_arm")
                        .offset(y: -17)
                }
            .padding(.top, 177-118)
            .task {
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

