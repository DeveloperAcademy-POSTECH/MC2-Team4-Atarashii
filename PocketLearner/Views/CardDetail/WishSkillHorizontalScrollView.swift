//
//  WishSkillHoriaontalScrollView.swift
//  PocketLearner
//
//  Created by 주환 on 2023/05/15.
//
import SwiftUI

struct WishSkillSetHorizontalScrollView: View {
    
    let skills: [String]
//    @Binding var skillsCount: [Int]
    
    let defaultSkillLogoTitles: [String] = ["Adobe CC", "Figma", "Firebase", "RxSwift", "Sketch", "Swift", "SwiftUI", "UIKit"]
    let randomSkillImageTitles: [String] = ["randomLogo_0", "randomLogo_1", "randomLogo_2", "randomLogo_3"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 17){
                ForEach(skills.indices, id: \.self) { index in
                    skillCard(skillName: skills[index])
                        .padding(.leading, index == 0 ? 20 : 0)
                }
            }.frame(height: 180)
        }
    }
    
    func skillCard(skillName: String) -> some View {
        return ZStack{
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .fill(Color.white)
                .frame(width: 120, height: 150)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            VStack{
                if defaultSkillLogoTitles.contains(skillName){
                    Image("\(skillName)")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(radius: 2))
                } else {
                    Image("\(randomSkillImageTitles.randomElement()!)")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(radius: 2))
                }
                Text("\(skillName)")
                    .font(.system(size: 14.5, weight: .bold))
                    .foregroundColor(.black)
            }
        }.frame(width: 120,height: 150)
    }
}

//struct WishSkillSetHorizontalScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        WishSkillSetHorizontalScrollView()
//    }
//}

