//
//  CardDetailView.swift
//  bletest
//
//  Created by 이재원 on 2023/05/07.
//

import Foundation
import SwiftUI

struct CardDetailView: View{
    let purpleColor1: Color = Color(red: 177/255, green: 140/255, blue: 254/255)
    let purpleColor2: Color = Color(red: 0.749, green: 0.745, blue: 1.0)
    let textGrayColor: Color = Color(red: 137/255, green: 138/255, blue: 141/255)
    let textPinkColor: Color = Color(red: 0.96, green: 0.68, blue: 0.70)
    
    @State var isHardSkillSet: Bool = true
    
    var body: some View{
        ScrollView{
            // curved rectangle, ignore safeArea to top.
            // (when user scroll to top, still can see the purple rectangle)
            ZStack (alignment: .top){
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(purpleColor2)
                    .frame(height: 800)
                    .offset(y: -400)
                VStack {
                    Group {
                        backHeader()
                        Spacer().frame(height: 70)
                        // "오후" in rounded purple rectangle
                        Text("오후")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 22)
                            .padding(.vertical, 5.5)
                            .background(purpleColor1)
                            .cornerRadius(40)
                        Text("Lianne")
                            .font(.system(size: 40, weight: .bold))
                            .scaleEffect(x: 1.2)
                        Spacer().frame(height: 280)
                    }
                    Group {
                        Text("안녕하세요! 겉바속촉\n디발자 리앤 입니다!")
                            .font(.system(size: 25, weight: .bold))
                            .multilineTextAlignment(.center)
                            .frame(height: 80)
                        Spacer().frame(height: 30)
                        skillCooperationButton()
                        Spacer().frame(height: 60)
                        
                        VStack{
                            Text("현재 이런 ")
                                .foregroundColor(.black)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("스킬셋")
                                .foregroundColor(textGrayColor)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("을\n")
                                .foregroundColor(.black)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("활용할 수 있어요!")
                                .foregroundColor(textPinkColor)
                                .font(.system(size: 20.5, weight: .bold))
                        }.fixedSize(horizontal: false, vertical: true)
                        
                        Spacer().frame(height: 30)
                        ScrollView(.horizontal){
                            
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.black)
                                .frame(width: 160, height: 220)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        Spacer().frame(height: 40)
                    }
                }
                VStack{
                    Spacer().frame(height: 300)
                    profileCircle()
                }

                VStack {
                    Spacer().frame(height: 95)
                }
            }
        }.ignoresSafeArea().frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    /// 눌렀을 때 Opacity가 변하지 않는 ButtonStyle 재정의
    struct buttonStyleNotOpacityChange: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
    
    func skillCooperationButton() -> some View {
        return Button(action: {
            withAnimation{
                isHardSkillSet.toggle()
            }
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 200, style: .continuous)
                    .fill(purpleColor2)
                    .frame(width: 300, height: 45)
                RoundedRectangle(cornerRadius: 200, style: .continuous)
                    .fill(Color.white)
                    .frame(width: 150, height: 37)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .offset(x: isHardSkillSet ? -71 : 71)
                Text("스킬")
                    .font(.system(size: 18, weight: isHardSkillSet ? .bold : .regular))
                    .offset(x: -71)
                Text("협업")
                    .font(.system(size: 18, weight: isHardSkillSet ? .regular : .bold))
                    .offset(x: 71)
            }.frame(width: 300, height: 45)
        }).buttonStyle(buttonStyleNotOpacityChange())
    }
    
    /// header with "only" back button
    func backHeader() -> some View {
        return HStack{
            Button(action: {
                
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
            }).padding(.leading, 20)
            Spacer()
        }.padding(.top, 50)
    }
    
    /// profile Image(Memoji) with Circle
    /// 190 x 190 pixel.
    func profileCircle() -> some View{
        Image("dummyPikachu")
            .resizable()
            .scaledToFit()
            .frame(width: 130, height: 130)
            .offset(x:5, y: 4)
            .padding(30)
            .background(Color.white)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(purpleColor1, lineWidth: 3.84)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView().previewDevice("iPhone 14")
    }
}
