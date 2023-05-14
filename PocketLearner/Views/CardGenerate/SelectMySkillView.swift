//
//  SelectMySkillView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/14.
//

import SwiftUI
import Flow

struct SelectMySkillView: View {
    
    // Header 관련 변수
    @State var activatedCircleNumber: Int = 2
    @State var headerTitleMessage: String = "나는 어떤 스킬을\n가지고 있나요?"
    @State var isHeaderDescriptionVisible: Bool = true
    @State var headerDescriptionMessage: String = "우리 모두는 다양한 스킬을 가지고있을 수 있어요. 예시중 원하는 선택지가 없다면 당신만의 스킬 키워드를 직접 입력해주세요!"
    
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
    
    // 버튼 뷰를 리턴하는 함수
    
    func returnSkillButton (buttonTitle: String, buttonColor: Color = .white) -> some View {
        
        return Button(action: {
        // Sheet 뷰 오픈
        // 버튼의 Title을 selectedSkillTitles에 append 한다.
            
        }) {
            Text(buttonTitle)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.black)
                .padding(.vertical, 5)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .fill(buttonColor)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y:  0.5)
                )
        }
        
    }
    
    // LazyGrid Column
    
    let skillButtonsGridColumns = [
           GridItem(.adaptive(minimum: 100, maximum: 12000))
       ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber, headerTitleMessage:  headerTitleMessage, isHeaderDescriptionVisible: isHeaderDescriptionVisible, headerDescriptionMessage: headerDescriptionMessage)
            
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
                    returnSkillButton (buttonTitle: item)
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 38)
            
            Spacer()
            
            cardGenerateViewsButton(title: "다음", disableCondition: true, action: {} )
                .padding(.horizontal, 38)

        }
        .padding(.top, 32)
        .sheet(isPresented: $showingSkillTitleInputSheet) {
            SkillTitleInputSheetView(appendArray: $defaultSkillsetTitles)
                .presentationDetents([.height(217)])
                .presentationDragIndicator(.hidden)
                
        }
    }
}

struct SelectMySkillView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMySkillView()
    }
}
