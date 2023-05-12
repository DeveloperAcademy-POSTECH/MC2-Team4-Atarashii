//
//  SelectCommunicationTypeView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/12.
//

import SwiftUI

struct SelectCommunicationTypeView: View {
    //Header 관련 변수
    @State var activatedCircleNumber: Int = 5
    @State var headerTitleMessage: String = "나의 커뮤니케이션 타입은?"
    @State var isHeaderDescriptionVisible: Bool = true
    @State var headerDescriptionMessage: String = "레베카 함께 했던 팀워크 워크샵을 기억하시나요?"
    // 카드 Rotation 관련 변수
    @State var isFlipped = false
    let durationAndDelay : CGFloat = 0.1
    // 카드 데이터 관련 변수
    @State var fourTypeCardsDatas : [FourTypeCardData] = [
        FourTypeCardData(title: "Analytical", englishDescription: "Fact-Based Introvert", description: "결과보다는 관계와 과정을,\n리스크 보다는 안정감을 중요시해요.", imageTitle: "analyticalCardImage"),
        FourTypeCardData(title: "Driver", englishDescription: "Fact-Based Extrovert", description: "추진력이 좋고 결과를 중시해요\n업무에서의 효율성을 추구해요.", imageTitle: "driverCardImage"),
        FourTypeCardData(title: "Amiable", englishDescription: "Relationship-Based Introvert", description: "팀원의 이야기를 경청하고 팔로우해요.\n변화보다는 안정감을 선호해요.", imageTitle: "amiableCardImage"),
        FourTypeCardData(title: "Expressive", englishDescription: "Relationship-Based Extrovert", description: "활발하게 소통하고, 창의적이에요\n팀원들간의 화합과 설득을 중시해요.", imageTitle: "expressiveCardImage")
    ]
    
    //카드 Rotation 관련 함수
    func flipCard(index: Int) {
        fourTypeCardsDatas[index].isFlipped.toggle()
        // fourTypeCardsDatas[index].isFlipped = !fourTypeCardsDatas[index].isFlipped
        if fourTypeCardsDatas[index].isFlipped {
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                fourTypeCardsDatas[index].backDegree = 0
            }
            withAnimation(.linear(duration: durationAndDelay)) {
                fourTypeCardsDatas[index].frontDegree = 90
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                fourTypeCardsDatas[index].frontDegree = 0
            }
            withAnimation(.linear(duration: durationAndDelay)) {
                fourTypeCardsDatas[index].backDegree = -90
            }
        }
        
         // 🔴 하나의 카드가 뒤집어질 경우, 다른 카드는 이니 뒤집혀 있더라도 다시 원상복구 되게 만드는 로직
//        for i in 0..<fourTypeCardsDatas.count {
//            if i != index {
//
//            }
//        }
    }
    var body: some View {
        VStack(spacing: 0) {
            CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, isHeaderDescriptionVisible: isHeaderDescriptionVisible, headerDescriptionMessage:headerDescriptionMessage)
            
            ZStack(alignment: .center){ // Cards + Coordinate View
                
                Image("communicationTypeCoordinate")
                    .resizable()
                    .frame(width: 354.71, height: 498)
                    .padding(.trailing, 2)
                    
                    
                VStack(spacing: 26.77) { // Cards
                    HStack(spacing: 23.9) { // Analytical, Driver
                            ZStack {
                                //Analytic 카드뷰
                                CommunicationStyleCardBack(degree: $fourTypeCardsDatas[0].backDegree)
                                CommunicationStyleCardFront(degree:$fourTypeCardsDatas[0].frontDegree, typeTitle:$fourTypeCardsDatas[0].title, typeEnglishDescription: $fourTypeCardsDatas[0].englishDescription, typeDescription: $fourTypeCardsDatas[0].description, typeImageTitle: $fourTypeCardsDatas[0].imageTitle)
                            }.onTapGesture {
                                // 탭했을때의 flip 제스쳐
                                flipCard(index: 0)
                            }

                            ZStack {
                                    //Driver 카드뷰
                                CommunicationStyleCardBack(degree: $fourTypeCardsDatas[1].backDegree)
                                CommunicationStyleCardFront(degree:$fourTypeCardsDatas[1].frontDegree, typeTitle:$fourTypeCardsDatas[1].title, typeEnglishDescription: $fourTypeCardsDatas[1].englishDescription, typeDescription: $fourTypeCardsDatas[1].description, typeImageTitle: $fourTypeCardsDatas[1].imageTitle)
                            }.onTapGesture {
                                    // 탭했을때의 flip 제스쳐
                                    flipCard(index: 1)
                            }
                        }
                    HStack(spacing: 23.9) { // Amiable, Expressive
                            ZStack {
                                //Amiable 카드뷰
                                CommunicationStyleCardBack(degree: $fourTypeCardsDatas[2].backDegree)
                                CommunicationStyleCardFront(
                                    degree: $fourTypeCardsDatas[2].frontDegree, typeTitle: $fourTypeCardsDatas[2].title, typeEnglishDescription: $fourTypeCardsDatas[2].englishDescription, typeDescription: $fourTypeCardsDatas[2].description, typeImageTitle: $fourTypeCardsDatas[2].imageTitle)
                            }.onTapGesture {
                                // 탭했을때의 flip 제스쳐
                                flipCard(index: 2)
                            }

                            ZStack {
                                    //Expressive 카드뷰
                                CommunicationStyleCardBack(degree: $fourTypeCardsDatas[3].backDegree)
                                CommunicationStyleCardFront(
                                    degree: $fourTypeCardsDatas[3].frontDegree, typeTitle: $fourTypeCardsDatas[3].title, typeEnglishDescription: $fourTypeCardsDatas[3].englishDescription, typeDescription: $fourTypeCardsDatas[3].description, typeImageTitle: $fourTypeCardsDatas[3].imageTitle)
                            }.onTapGesture {
                                    // 탭했을때의 flip 제스쳐
                                    flipCard(index: 3)
                            }
                        }
                   
                }
                .offset(y: 6)
            }
            .padding(.top, 16)
            
            cardGenerateViewsButton(title:"다음", disableCondition: false, action: {} )
                .padding(.top, 30)
            Spacer()

        }
    }
}

struct FourTypeCardData {
    var title: String
    var englishDescription: String
    var description: String
    var imageTitle: String
    var frontDegree: Double = 0.0
    var backDegree: Double = -90.0
    var isFlipped: Bool = false
}

struct SelectCommunicationTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCommunicationTypeView()
    }
}
