//
//  skillSetHorizontalScrollView.swift
//  bletest
//
//  Created by 이재원 on 2023/05/08.
//

import SwiftUI

struct SkillSetHorizontalScrollView: View {
    
    let skills: [String]
    let skillCounts: [Int]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(skills.indices, id: \.self) { index in
                    skillCard(skillName: skills[index],skillCount: skillCounts[index])
                        .padding(.leading, index == 0 ? 20 : 0)
                }
            }
        }
    }
    
    func skillCard(skillName: String, skillCount: Int) -> some View {
        return ZStack{
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white)
                .frame(width: 200, height: 280)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            VStack{
                Spacer().frame(height: 20)
                Image("communicationTypeCardKangaroo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .offset(y: 3)
                    .padding(30)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                Text("\(skillName)")
                    .font(.system(size: 14.5, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.vertical, 3)
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 200, style: .continuous)
                        .fill(gaugeGrayColor)
                        .frame(width: 160, height: 22)
                        .overlay(
                            RoundedRectangle(cornerRadius: 200, style: .continuous)
                                .stroke(radiusGrayColor, lineWidth: 1)
                        )
                    RoundedRectangle(cornerRadius: 200, style: .continuous)
                        .fill(cardColorList.randomElement()!)
                        .frame(width: 160 * CGFloat(skillCount) * 0.01, height: 22)
                    Text("\(String(skillCount)) %")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.black)
                        .offset(x: 150*0.7 - 30)
                }
                Text("활용이 익숙하고, 팀원들에게\n지식 공유를 할 수 있어요.")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
                Spacer().frame(height: 20)
            }.frame(width: 220, height: 370)
        }
    }
}

//struct SkillSetHorizontalScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        SkillSetHorizontalScrollView()
//    }
//}
