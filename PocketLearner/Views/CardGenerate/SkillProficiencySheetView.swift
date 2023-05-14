//
//  SkillProficiencySheetView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/14.
//

import SwiftUI

struct SkillProficiencySheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var sliderValue = 0.0
    @Binding var appendTitleArray: [String]
    @Binding var appendProficiencyArray : [Int]
   
    
    var body: some View {
        VStack(spacing: 10){
            HStack { // X버튼
                Spacer()
                
                Button(action: {
                    dismiss()
                    appendTitleArray.removeLast()
                    
                }){
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                }
                
            }
            .padding(.trailing, 20)
            Text("이 스킬셋에 대해 어느정도의\n숙련도를 가지고 계신가요?")
                .font(.system(size: 18, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 7)
            HStack(spacing: 4) {
                Text("스킬 숙련도")
                    .foregroundColor(.black)
                    .font(.system(size: 12.1, weight: .light))
                Text("\(Int(sliderValue))%")
                    .foregroundColor(
                        sliderValue <= 30 ? Color(buttonEditAbledPinkColor) : (sliderValue >= 80 ? cardBackgroundColor_4 : cardBackgroundColor_5)
                    )
                    .font(.system(size: 15.4, weight: .black))
            }
            .padding(.horizontal, 21.05)
            .padding(.vertical, 5.85)
            .background(
                RoundedRectangle(cornerRadius: 28.8)
                    .fill(.white)
                    .shadow(radius: 4, x: 0, y: 0.5)
            )
            .padding(.top, 13)
            
            Text(
                sliderValue <= 30 ? "한 두번 경험은 해보았지만, 활용이 익숙하지는 않아요!" : (sliderValue >= 80 ? "능숙하게 다룰 수 있고, 팀원들에게 지식 공유를 할 수 있어요." : "경험을 쌓아가며 익숙해지고 있는 단계에 있어요 ! ")
            )
                .foregroundColor(
                    sliderValue <= 30 ? Color(buttonEditAbledPinkColor) : (sliderValue >= 80 ? cardBackgroundColor_4 : cardBackgroundColor_5)
                )
                .font(.system(size: 13, weight: .medium))
            
            Slider(value: $sliderValue, in: 0...100, step: 10)
                .padding(.horizontal, 41)
                .accentColor(
                    sliderValue <= 30 ? Color(buttonEditAbledPinkColor) : (sliderValue >= 80 ? cardBackgroundColor_4 : cardBackgroundColor_5)
                )
            
            cardGenerateViewsButton(title: "이 키워드 입력", disableCondition: sliderValue == 0.0, action: {
                // 이 숙련도를 부모뷰의 array에 append
                appendProficiencyArray.append(Int(sliderValue))
                appendProficiencyArray.remove(at: appendProficiencyArray.count-2)
                // 이 뷰를 dismiss 되게 만들어야
                dismiss()
            })
            .padding(.top, 16)
            
            
        }
        .interactiveDismissDisabled()
    }
}

//struct SkillProficiencySheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkillProficiencySheetView()
//    }
//}
