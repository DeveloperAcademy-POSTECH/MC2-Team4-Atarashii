//
//  SelectCollaborationKeywordView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/12.
//

import SwiftUI

struct SelectCollaborationKeywordView: View {
    @State var activatedCircleNumber: Int = 6
    @State var headerTitleMessage: String = "나와 어울리는\n협업 키워드는?"
    @State var isHeaderDescriptionVisible: Bool = true
    @State var headerDescriptionMessage: String = "협업 키워드를 3개 선택해주세요."
    
    // 키워드 원형 버튼 관련 변수
    let buttonDatas: [CollaborationButtonData] = [
        CollaborationButtonData(buttonColor: collaborationKeywordColor_0, buttonTitle: "갈등중재"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_1, buttonTitle: "리더십"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_2, buttonTitle: "팔로워십"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_3, buttonTitle: "소통왕"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_4, buttonTitle: "감성지능"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_5, buttonTitle: "비판적\n사고"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_6, buttonTitle: "공감능력"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_7, buttonTitle: "유연한\n사고"),
    ]
    
    @State var selectedCollaborationKeywords = [String]()
 

   
    
    var body: some View {
        VStack{
            
            CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, isHeaderDescriptionVisible: isHeaderDescriptionVisible, headerDescriptionMessage:headerDescriptionMessage)
            
            
            VStack(spacing: 0) {
                HStack(spacing: 15) { // 첫 가로축
                    
                    CollaborationKeywordButton(buttonColor: buttonDatas[0].buttonColor, buttonTitle: buttonDatas[0].buttonTitle , buttonSelectAction: {
                        if self.selectedCollaborationKeywords.count < 3 {
                            selectedCollaborationKeywords.append(buttonDatas[0].buttonTitle)
                        }
                    },
                    buttonDisselectAction: {
                        if self.selectedCollaborationKeywords.count > 0 {
                            selectedCollaborationKeywords.remove(at: (selectedCollaborationKeywords.firstIndex(of: buttonDatas[0].buttonTitle))!)
                        }
                    })
                    
                    CollaborationKeywordButton(buttonColor: buttonDatas[1].buttonColor, buttonTitle: buttonDatas[1].buttonTitle,
                                               buttonSelectAction: {
                                                   if self.selectedCollaborationKeywords.count < 3 {
                                                       selectedCollaborationKeywords.append(buttonDatas[1].buttonTitle)
                                                   }
                                               },
                                               buttonDisselectAction: {
                                                   if self.selectedCollaborationKeywords.count > 0 {
                                                       selectedCollaborationKeywords.remove(at: (selectedCollaborationKeywords.firstIndex(of: buttonDatas[1].buttonTitle))!)
                                                   }
                                               })
                        .padding(.top, 36)
                    
                    CollaborationKeywordButton(buttonColor: buttonDatas[2].buttonColor, buttonTitle: buttonDatas[2].buttonTitle , buttonSelectAction: {
                        if self.selectedCollaborationKeywords.count < 3 {
                            selectedCollaborationKeywords.append(buttonDatas[2].buttonTitle)
                        }
                    },
                    buttonDisselectAction: {
                        if self.selectedCollaborationKeywords.count > 0 {
                            selectedCollaborationKeywords.remove(at: (selectedCollaborationKeywords.firstIndex(of: buttonDatas[2].buttonTitle))!)
                        }
                    })
                    
                }
                
                HStack(spacing: 15){ // 두번째 가로축
                    
                    CollaborationKeywordButton(buttonColor: buttonDatas[3].buttonColor, buttonTitle: buttonDatas[3].buttonTitle, buttonSelectAction: {
                        if self.selectedCollaborationKeywords.count < 3 {
                            selectedCollaborationKeywords.append(buttonDatas[3].buttonTitle)
                        }
                    },
                    buttonDisselectAction: {
                        if self.selectedCollaborationKeywords.count > 0 {
                            selectedCollaborationKeywords.remove(at: (selectedCollaborationKeywords.firstIndex(of: buttonDatas[3].buttonTitle))!)
                        }
                    })
                        .padding(.leading, 36)
                    
                    Spacer()
                    
                    CollaborationKeywordButton(buttonColor: buttonDatas[4].buttonColor, buttonTitle: buttonDatas[4].buttonTitle,buttonSelectAction: {
                        if self.selectedCollaborationKeywords.count < 3 {
                            selectedCollaborationKeywords.append(buttonDatas[4].buttonTitle)
                        }
                    },
                    buttonDisselectAction: {
                        if self.selectedCollaborationKeywords.count > 0 {
                            selectedCollaborationKeywords.remove(at: (selectedCollaborationKeywords.firstIndex(of: buttonDatas[4].buttonTitle))!)
                        }
                    })
                        .padding(.trailing, 36)
                    
                }
                
                HStack(spacing: 15){ // 첫 가로축
                    
                    CollaborationKeywordButton(buttonColor: buttonDatas[5].buttonColor, buttonTitle: buttonDatas[5].buttonTitle , buttonSelectAction: {
                        if self.selectedCollaborationKeywords.count < 3 {
                            selectedCollaborationKeywords.append(buttonDatas[5].buttonTitle)
                        }
                    },
                    buttonDisselectAction: {
                        if self.selectedCollaborationKeywords.count > 0 {
                            selectedCollaborationKeywords.remove(at: (selectedCollaborationKeywords.firstIndex(of: buttonDatas[5].buttonTitle))!)
                        }
                    })
                    
                    CollaborationKeywordButton(buttonColor: buttonDatas[6].buttonColor, buttonTitle: buttonDatas[6].buttonTitle, buttonSelectAction: {
                        if self.selectedCollaborationKeywords.count < 3 {
                            selectedCollaborationKeywords.append(buttonDatas[6].buttonTitle)
                        }
                    },
                    buttonDisselectAction: {
                        if self.selectedCollaborationKeywords.count > 0 {
                            selectedCollaborationKeywords.remove(at: (selectedCollaborationKeywords.firstIndex(of: buttonDatas[6].buttonTitle))!)
                        }
                    })
                        .padding(.bottom, 36)
                    
                    CollaborationKeywordButton(buttonColor: buttonDatas[7].buttonColor, buttonTitle: buttonDatas[7].buttonTitle, buttonSelectAction: {
                        if self.selectedCollaborationKeywords.count < 3 {
                            selectedCollaborationKeywords.append(buttonDatas[7].buttonTitle)
                        }
                    },
                    buttonDisselectAction: {
                        if self.selectedCollaborationKeywords.count > 0 {
                            selectedCollaborationKeywords.remove(at: (selectedCollaborationKeywords.firstIndex(of: buttonDatas[7].buttonTitle))!)
                        }
                    })
                    
                }
                
                Spacer()
                
                cardGenerateViewsButton(title: "다음", disableCondition: false, action: {} )
                    

                
                
            }
            .padding(.top, 60)
            .padding(.bottom, 20)
            .frame(width: 330)
        }
    }
}

struct CollaborationButtonData {
    var buttonColor: Color = .green
    var buttonTitle: String = "유연한 사고"
    var isSelected: Bool = false
}

// 버튼 뷰를 리턴하는 Struct

struct CollaborationKeywordButton : View {
    @State var buttonColor: Color
    @State var buttonTitle: String
    @State var isSelected: Bool = false
    @State var buttonSelectAction : () -> Void = {}
    @State var buttonDisselectAction : () -> Void = {}
    
    var body: some View {
        Button( action:
           
        {
            // 1. Selected의 경우, 정보를 전달, 및 motion 구현 DisSelect일 경우, 정보를 삭제.
            if self.isSelected == false {
                buttonSelectAction
            }
            
            else { // DisSelected
                buttonDisselectAction
            }
            
            withAnimation(.linear(duration: 0.02)){
                // 2. isSelected를 토글
                self.isSelected.toggle()
            }

        }
            // 2. Selected 되는 모션 (커지고 색깔 fill 되는)
            // 3. 버튼 타이틀을 selectedCollaborationKeyword 값으로  할당.
            // self.selectedCollaborationKeyword = buttonTitle
        ){
            ZStack {
                Circle() // DisSlected
                    .stroke(isSelected ? .clear : buttonColor , lineWidth: 3)
                    .frame(width: 90, height:90)
                Circle() // Selected
                    .fill(isSelected ? buttonColor : .clear)
                    .frame(width: isSelected ? 110 : 90, height: isSelected ? 110 : 90)
                Text(buttonTitle)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(self.isSelected ?  .white : buttonColor)
            }
            
        }
    }
    
}


struct SelectCollaborationKeywordView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCollaborationKeywordView()
    }
}
