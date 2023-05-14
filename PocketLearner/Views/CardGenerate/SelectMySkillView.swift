//
//  SelectMySkillView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/14.
//

import SwiftUI
import Flow

struct SelectMySkillView: View {
    
    @ObservedObject var card: CardDetailData
    
    @State var goNext: Bool = false
    let isMySkill: Bool     // true -> 내 스킬, false -> 키우고 싶은 스킬
    // Header 관련 변수
    @State var activatedCircleNumber: Int = 2
    @State var headerTitleMessage: String = "나는 어떤 스킬을\n가지고 있나요?"
    @State var isHeaderDescriptionVisible: Bool = true
    @State var headerDescriptionMessage: String = "우리 모두는 다양한 스킬을 가지고있을 수 있어요. 예시중 원하는 선택지가 없다면 당신만의 스킬 키워드를 직접 입력해주세요!"
    
    let activatedCircleNumber2 = 4
    let headerTitleMessage2 = "나는 어떤 스킬을\n키우고 싶나요?"
    let headerDescriptionMessage2 = "우리 모두는 주어진 예시 외에도, 다양한 스킬을 키울 수 있어요.\n원하는 선택지가 없다면 당신만의 스킬 키워드를 직접 입력해주세요!"
    
    // DB로 보낼 변수
    @State var selectedSkillTitles = [String]() // 스킬의 이름을 담는 배열
    @State var selectedSkillProficiency = [Int]() // 스킬의 숙련도를 담는 배열
    
    // Sheet 관련 toggle 변수
    
    // 해당 키워드의 숙련도 정보를 입력받는 Sheet의 토글
    @State var showingSkillProficiencySheet: Bool = false
    // 새로운 키워드를 입력받는 Sheet의 토글
    @State var showingSkillTitleInputSheet: Bool = false
    
    // Sheet에서 받아오는 정보 변수
    @State var skillsetTitleInput: String = ""
    
    @State var defaultSkillsetTitles = ["UX 라이팅", "UX 분석", "KPI 설계", "프로덕트 매니징", "대시보드 / 데이터 분석", "SwiftUI", "UIKit", "Swift", "Firebase", "Combine", "RxSwift", "와이어프레이밍", "디자인 띵킹", "low-fi / hi-fi 프로토타이핑", "페르소나 제작", "유저 저니맵 제작", "Figma", "Sketch", "Adobe CC"]
    
    func returnColor(proficiency: Int) -> Color {
        switch proficiency {
        case 10..<30 :
            return Color(buttonEditAbledPinkColor)
        case 40...80 :
            return cardBackgroundColor_5
        case 90...100 :
            return cardBackgroundColor_4
        default :
            return .white
        }
    }
    
    // LazyGrid Column
    
    let skillButtonsGridColumns = [
           GridItem(.adaptive(minimum: 100, maximum: 12000))
       ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            if isMySkill{
                CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber, headerTitleMessage:  headerTitleMessage, isHeaderDescriptionVisible: isHeaderDescriptionVisible, headerDescriptionMessage: headerDescriptionMessage)
            } else {
                CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber2, headerTitleMessage: headerTitleMessage2, isHeaderDescriptionVisible: isHeaderDescriptionVisible, headerDescriptionMessage: headerDescriptionMessage2)
            }
            
            Button(action: {
                // skill 키워드를 입력받는 Sheet을 show
                showingSkillTitleInputSheet.toggle()
            }){
                HStack(spacing: 7){
                    Image(systemName: "plus")
                        .font(.system(size: 15, weight: .medium))
                    Text("직접입력")
                        .font(.system(size: 15, weight: .medium))
                }
                .padding(.vertical, 5)
                .padding(.leading, 9)
                .padding(.trailing, 13)
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .stroke(lineWidth: 1)
                )
            }
            .padding(.leading, 38)
            .padding(.top, 29)
            
            // FlowLayout
            HFlow(alignment: .top, spacing: 9) {
                ForEach(defaultSkillsetTitles, id: \.self){ item in
                    returnSkillButton(buttonTitle: item)
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 38)
            
            Spacer()
            
            cardGenerateViewsButton(title: "다음", disableCondition: false, action: {
                if isMySkill{
                    card.skills = selectedSkillTitles
                    card.skillLevel = selectedSkillProficiency
                } else {
                    card.wishSkills = selectedSkillTitles
//                    card.wi
                }
                goNext = true
            }).padding(.horizontal, 38).navigationDestination(isPresented: $goNext){
                if isMySkill{
                    MyCurrentSkillsetTextEditorView(card: card)
                } else {
                    MyWishSkillsetTextEditorView(card: card)
                }
            }

        }
        .padding(.top, 32)
        .sheet(isPresented: $showingSkillTitleInputSheet) {
            SkillTitleInputSheetView(appendArray: $defaultSkillsetTitles)
                .presentationDetents([.height(217)])
                .presentationDragIndicator(.hidden)
                
        }
        .sheet(isPresented: $showingSkillProficiencySheet) {
            SkillProficiencySheetView(appendTitleArray: $selectedSkillTitles, appendProficiencyArray: $selectedSkillProficiency)
                .presentationDetents([.height(321)])
                .presentationDragIndicator(.hidden)
                
        }
    }
    
    // 버튼 뷰를 리턴하는 함수
    func returnSkillButton (buttonTitle: String, buttonColor: Color = .white) -> some View {
        
        var buttonColor: Color = mainAccentColor
        var proficiency:Int = 0
        let index = selectedSkillTitles.firstIndex(of: buttonTitle) ?? -1
        if index != -1{
            proficiency = selectedSkillProficiency[index]
            
            if proficiency <= 30 {
                buttonColor = Color(buttonEditAbledPinkColor)
            } else if proficiency <= 70 {
                buttonColor = cardBackgroundColor_5
            } else {
                buttonColor = cardBackgroundColor_4
            }
        }
        
        return Button(action: {
        // 버튼의 Title을 selectedSkillTitles에 append 한다.
            selectedSkillTitles.append(buttonTitle)
            selectedSkillProficiency.append(0)
        // Sheet 뷰 오픈
            if isMySkill{
                showingSkillProficiencySheet.toggle()
            }
            
        }) {
                    Text(buttonTitle)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 12)
                        .background(
                            isMySkill ?
                            RoundedRectangle(cornerRadius: 35)
                                .fill(
                                    // 이 버튼 타이틀의 인덱스에 맞는 퍼센트의 범위에 따라 .
                                    selectedSkillTitles.contains(buttonTitle) ? (
                                        // 숙련도 정보가 append된 상태인지 아닌지 검사
                                        // 특정 인덱스의 숙련도 값에 따라 색 지정
                                        selectedSkillTitles.count == selectedSkillProficiency.count ? buttonColor : .white
                                    ) : .white
                                ).shadow(color: .black.opacity(0.25), radius: 4, x: 0, y:  0.5)

                            
                            : RoundedRectangle(cornerRadius: 35)
                                .fill(
                                    selectedSkillTitles.contains(buttonTitle) ? (mainAccentColor) : .white
                                ).shadow(color: .black.opacity(0.25), radius: 4, x: 0, y:  0.5)
                        )

        }
        .disabled(selectedSkillTitles.contains(buttonTitle))
    }
}
