//
//  skillSetHorizontalScrollView.swift
//  bletest
//
//  Created by 이재원 on 2023/05/08.
//

import SwiftUI

struct SkillSetHorizontalScrollView: View {
    
    enum levelText: String, CaseIterable{
        case level1 = "경험을 쌓아가며 익숙해지고 있는 단계에 있어요 ! "
        case level2 = "경험은 해보았지만 \n활용이 익숙하지는 않아요!"
        case level3 = "활용이 익숙하고, 팀원들에게\n지식 공유를 할 수 있어요!"
    }

    let skills: [String]
    let skillCounts: [Int]
    
    let defaultSkillLogoTitles: [String] = ["Adobe CC", "Figma", "Firebase", "RxSwift", "Sketch", "Swift", "SwiftUI", "UIKit"]
    let randomSkillImageTitles: [String] = ["randomLogo_0", "randomLogo_1", "randomLogo_2", "randomLogo_3"]
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 17) {
                ForEach(skills.indices, id: \.self) { index in
                    skillCard(skillName: skills[index],skillCount: skillCounts[index])
                        .padding(.leading, index == 0 ? 20 : 0)
                }
            }
            .frame(height: 250)
        }
    }
    
    func skillCard(skillName: String, skillCount: Int) -> some View {
        return ZStack{
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .fill(Color.white)
                .frame(width: 150, height: 210)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            VStack{
                if defaultSkillLogoTitles.contains(skillName){ // defaultSkillLogoTitles에 해당 skill의 이름이 있을 경우 => 해당 스킬에 대한 로고가 있는 것.
                    Image("\(skillName)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 72, height: 72)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.white)
                            .frame(width: 72,height: 72)
                            .shadow(radius: 2)
                        )
                } else { // defaultSkillLogoTitles에 해당 skill의 이름이 없을 경우 => 해당 스킬에 대한 로고가 없는 것. => 이때는 랜덤으로 준비된 일러스트중 하나를 선택.
                    Image("\(randomSkillImageTitles.randomElement()!)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 72, height: 72)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white)
                            .frame(width: 72,height: 72)
                            .shadow(radius: 2)
                        )
                }
                Text("\(skillName)")
                    .font(.system(size: 14.5, weight: .bold))
                    .foregroundColor(.black)
//                    .padding(.vertical, 3)
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 200, style: .continuous)
                        .fill(gaugeGrayColor)
                        .frame(width: 121, height: 15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 200, style: .continuous)
                                .stroke(radiusGrayColor, lineWidth: 1)
                        )
                    RoundedRectangle(cornerRadius: 200, style: .continuous)
                        .fill(returnColor(proficiency: skillCount))
                        .frame(width: 121 * CGFloat(skillCount) * 0.01, height: 15)
                    Text("\(String(skillCount)) %")
                        .font(.system(size: 7.62, weight: .bold))
                        .foregroundColor(.black)
                        .offset(x: 150*0.7 - 30)
                }
                Text(returnText(proficiency: skillCount).rawValue)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(height: 31)
            }
        }
        .frame(width: 150, height: 210)
    }
    
    func returnColor(proficiency: Int) -> Color {
        switch proficiency {
        case 10..<39 :
//            level = .level1
            return cardBackgroundColor_0
        case 40...80 :
//            level = .level2
            return cardBackgroundColor_5
        case 90...100 :
//            level = .level3
            return cardBackgroundColor_4
        default :
//            level = .level1
            return .white
        }
    }
    func returnText(proficiency: Int) -> levelText {
        switch proficiency {
        case 10..<39 :
            return levelText.level1
        case 40...80 :
//            level = .level2
            return levelText.level2
        case 90...100 :
//            level = .level3
            return levelText.level3
        default :
//            level = .level1
            return levelText.level1
        }
    }
    
}

//struct SkillSetHorizontalScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkillSetHorizontalScrollView()
//    }
//}
