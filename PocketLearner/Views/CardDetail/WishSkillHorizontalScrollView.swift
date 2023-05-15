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
            HStack{
                ForEach(skills.indices, id: \.self) { index in
                    skillCard(skillName: skills[index])
                        .padding(.leading, index == 0 ? 20 : 0)
                }
            }
        }
    }
    
    func skillCard(skillName: String) -> some View {
        return ZStack{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
                .frame(width: 200, height: 250)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            VStack{
                Spacer().frame(height: 20)
                if defaultSkillLogoTitles.contains(skillName){
                    Image("\(skillName)")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .offset(y: 3)
                        .padding(30)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.white))
                        .shadow(radius: 2)
                } else {
                    Image("\(randomSkillImageTitles.randomElement()!)")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .offset(y: 3)
                        .padding(30)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.white))
                        .shadow(radius: 2)
                }
                Text("\(skillName)")
                    .font(.system(size: 14.5, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.vertical, 3)
            }.frame(width: 220, height: 370)
        }
    }
}

//struct WishSkillSetHorizontalScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        WishSkillSetHorizontalScrollView()
//    }
//}

