//
//  CardGenerateTextEditorView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/10.
//

import SwiftUI

struct IntroductionTextEditorView: View {
    let activatedCircleNumber: Int = 1
    let headerTitleMessage: String = "나를 소개하는\n한문장을 적어주세요!"
    let placeHolder: String = "나를 가장 잘 표현할 수 있는 문장을\n50자 이내로 작성해주세요."
    let letterLimit: Int = 50
    @State var goNext: Bool = false
    
    @StateObject var card: CardDetailData = CardDetailData()
    
    var body: some View {
        CardGenerateTextEditorView(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, placeHolder: placeHolder, letterLimit: letterLimit, goNext: $goNext, card: card)
            .navigationDestination(isPresented: $goNext){
                MyCurrentSkillsetTextEditorView(card: card)
            }
    }
}

struct MyCurrentSkillsetTextEditorView: View {
    let activatedCircleNumber: Int = 2
    let headerTitleMessage: String = "나의 스킬셋에 대해\n자세히 서술해주세요."
    let placeHolder: String = "내가 현재 가지고 있는 스킬셋에 대해 자세하게 서술해주세요!"
    let letterLimit: Int = 150
    @State var goNext: Bool = false
    
    @ObservedObject var card: CardDetailData
    
    var body: some View {
        CardGenerateTextEditorView(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, placeHolder: placeHolder, letterLimit: letterLimit, goNext: $goNext, card: card)
            .navigationDestination(isPresented: $goNext){
                SelectRoleGoalView(card: card)
            }
    }
}

struct MyWishSkillsetTextEditorView: View {
    let activatedCircleNumber: Int = 4
    let headerTitleMessage: String = "키우고 싶은 스킬셋에 대해\n자세히 서술해주세요."
    let placeHolder: String = "키우고 싶은 스킬에 대해 자세하게 서술해주세요!"
    let letterLimit: Int = 150
    @State var goNext: Bool = false
    
    @ObservedObject var card: CardDetailData
    
    var body: some View {
        CardGenerateTextEditorView(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, placeHolder: placeHolder, letterLimit: letterLimit, goNext: $goNext, card: card)
            .navigationDestination(isPresented: $goNext){
                SelectCommunicationTypeView(card: card)
            }
    }
}

struct MyCollaborativeTendencyTextEditorView: View {
    let activatedCircleNumber: Int = 6
    let headerTitleMessage: String = "나의 협업 성향 및 가치관에 대해\n자세히 서술해주세요."
    let placeHolder: String = "나의 협업 성향 및 가치관에 대해 자세히 서술해주세요!"
    let letterLimit: Int = 150
    @State var goNext: Bool = false
    
    @ObservedObject var card: CardDetailData
    
    var body: some View {
        CardGenerateTextEditorView(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, placeHolder: placeHolder, letterLimit: letterLimit, goNext: $goNext, card: card)
            .navigationDestination(isPresented: $goNext){
                //FinishGenerateView(card: card)
            }
    }
}


struct CardGenerateTextEditorView: View {
    @State var inputText : String = ""
    let activatedCircleNumber: Int
    let headerTitleMessage: String
    let placeHolder: String
    let letterLimit: Int
    @State var isHeaderDescriptionVisible: Bool = false
    @State var headerDescriptionMessage: String = "우리 모두는 주어진 예시 외에도, 다양한 스킬을 가지고 있을 수 있어요.\n원하는 보기가 없다면 당신만의 스킬 키워드를 직접 입력해주세요!"
    
    @Binding var goNext: Bool
    
    @ObservedObject var card: CardDetailData = CardDetailData()
    
    var body: some View {
        VStack(spacing: 34) {
            VStack(alignment: .trailing){
                // 뷰의 조건에 맞는 헤더 입력.
                CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, isHeaderDescriptionVisible: isHeaderDescriptionVisible, headerDescriptionMessage: headerTitleMessage)
            }
            VStack { // 텍스트에디터 + 하단 버튼
                letterLimitTextField(placeholder: placeHolder, commentText: $inputText, letterLimit: letterLimit)
                    .padding(.top, 14)
                    .padding(.horizontal, 37)
                
                cardGenerateViewsButton(title:"다음", disableCondition: self.inputText.count == 0, action: {
                    switch activatedCircleNumber {
                    case 1:
                        card.introduce = inputText
                    case 2:
                        card.introduceSkill = inputText
                    case 4:
                        card.wishSkillIntroduce = inputText
                    case 6:
                        card.cooperationIntroduce = inputText
                    default:
                        print("error on CardGenerateTextEditorView")
                    }
                    goNext = true
                }).padding(.top, 20)
            }
            
            Spacer()
        }
        .onTapGesture {
            UtilFunction.noKeyboard()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    switch activatedCircleNumber {
                    case 1:
                        card.introduce = inputText
                    case 2:
                        card.introduceSkill = inputText
                    case 4:
                        card.wishSkillIntroduce = inputText
                    case 6:
                        card.cooperationIntroduce = inputText
                    default:
                        print("error on CardGenerateTextEditorView")
                    }
                    goNext = true
                }){
                    Text("나중에 적을래요")
                        .foregroundColor(Color("mainAccentColor"))
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.trailing, 5)
                }
            }
        }
    }
}

