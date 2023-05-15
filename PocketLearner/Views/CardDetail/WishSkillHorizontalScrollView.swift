//
//  WishSkillHoriaontalScrollView.swift
//  PocketLearner
//
//  Created by 주환 on 2023/05/15.
//
import SwiftUI

struct WishSkillSetHorizontalScrollView: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(Array(["Figma", "GitHub", "SwiftUI", "Combine", "RxSwift"].enumerated()), id: \.element) { (index, skillName) in
                    skillCard(skillName: skillName)
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
                Image("communicationTypeCardKangaroo")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .offset(y: 3)
                    .padding(30)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.white))
                    .shadow(radius: 2)
                Text("\(skillName)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.vertical, 3)
            }.frame(width: 220, height: 370)
        }
    }
}

struct WishSkillSetHorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        WishSkillSetHorizontalScrollView()
    }
}

