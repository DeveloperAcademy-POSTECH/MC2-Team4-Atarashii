//
//  CardDetailView.swift
//  bletest
//
//  Created by 이재원 on 2023/05/07.
//

import Foundation
import SwiftUI

struct CardDetailView: View{
    let introduceText: String = """
    Sketch보다는 Figma를 선호하는 취향이 확고한
    편이에요 :) 저는 디자인 업무를 주로 해봤기 때문
    에 디자인 툴 활용이 익숙하지만, iOS 개발자로서
    의 커리어를 좀 더 키우고 싶어요, UIKit은 이제 배
    우고 있는 단계이지만, SwiftUI는 나름 능숙하게
    다룰 수 있답니다!
    """
    let introduceText2: String = """
    개발공부를 시작한지 얼마 안되기도 했고, 다른 개
    발자와 협업해 본 적이 없어서 Git CLI가 익숙하지
    않아요! 같이 Git 공부할 사람?
    """
    
    @State var isHardSkillSet: Bool = true
    @State var isHardSkillSet_Button: Bool = true
    
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
                        VStack{
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
                        }
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
                    }
                    if isHardSkillSet{
                        VStack{
                            Text("현재 이런 ")
                                .foregroundColor(.black)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("스킬셋")
                                .foregroundColor(textGrayColor2)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("을\n")
                                .foregroundColor(.black)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("활용할 수 있어요!")
                                .foregroundColor(textPinkColor)
                                .font(.system(size: 20.5, weight: .bold))
                        }.fixedSize(horizontal: false, vertical: true)
                        
                        
                        SkillSetHorizontalScrollView()
                            .padding(.leading, 20)
                        
                        Spacer().frame(height: 20)
                        
                        Text(introduceText)
                            .font(.system(size: 16, weight: .regular))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 20)
                            .lineSpacing(7)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(textBackgroundGrayColor)
                            )
                        
                        Spacer().frame(height: 60)
                        VStack{
                            Text("앞으로 이런 ")
                                .foregroundColor(.black)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("스킬셋")
                                .foregroundColor(textGrayColor2)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("을\n")
                                .foregroundColor(.black)
                                .font(.system(size: 20.5, weight: .bold))
                            + Text("키우고 싶어요!")
                                .foregroundColor(textPinkColor)
                                .font(.system(size: 20.5, weight: .bold))
                        }.fixedSize(horizontal: false, vertical: true)
                        
                        SkillSetHorizontalScrollView()
                            .padding(.leading, 20)
                        
                        Spacer().frame(height: 20)
                        
                        Text(introduceText2)
                            .font(.system(size: 16, weight: .regular))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 20)
                            .lineSpacing(7)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(textBackgroundGrayColor)
                            )
                    }
                    else {
                        Text("제 커뮤니케이션 타입은")
                            .font(.system(size: 22, weight: .bold))
                            .padding(.bottom, 30)
                        ZStack{
                            RoundedRectangle(cornerRadius: 65, style: .continuous)
                                .fill(Color.white)
                                .frame(width: 300, height: 300)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                            VStack{
                                Image("dummyPikachu")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                                Text("Amiable")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.top, 20)
                                    .padding(.bottom, 10)
                                Text("결과보다는 관계와 과정을,\n리스크 보다는 안정감을 중요시해요.")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        Text("저와 어울리는 협업 키워드는")
                            .font(.system(size: 22, weight: .bold))
                            .padding(.top, 70)
                            .padding(.bottom, 30)
                        HStack{
                            ZStack {
                                Circle()
                                    .stroke(Color.purple, lineWidth: 3)
                                    .frame(width: 100, height: 100)
                                Text("갈등중재")
                                    .font(.system(size: 20, weight: .bold))
                            }.padding(.horizontal, 10)
                            ZStack {
                                Circle()
                                    .stroke(Color.blue, lineWidth: 3)
                                    .frame(width: 100, height: 100)
                                Text("갈등중재")
                                    .font(.system(size: 20, weight: .bold))
                            }.padding(.horizontal, 10)
                            ZStack {
                                Circle()
                                    .stroke(Color.red, lineWidth: 3)
                                    .frame(width: 100, height: 100)
                                Text("갈등중재")
                                    .font(.system(size: 20, weight: .bold))
                            }.padding(.horizontal, 10)
                        }.padding(.bottom, 50)
                        Text(introduceText)
                            .font(.system(size: 16, weight: .regular))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 20)
                            .lineSpacing(7)
                            .padding(.vertical, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(textBackgroundGrayColor)
                            )

                    }
                }
                VStack{
                    profileCircle().padding(.top, 300)
                }
            }
            VStack {
                Spacer().frame(height: 95)
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
            withAnimation(.easeOut(duration: 0.3)){
                isHardSkillSet_Button.toggle()
            }
            withAnimation(.easeOut(duration: 0.6)){
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
                    .offset(x: isHardSkillSet_Button ? -71 : 71)
                Text("스킬")
                    .font(.system(size: 18, weight: isHardSkillSet_Button ? .bold : .regular))
                    .offset(x: -71)
                Text("협업")
                    .font(.system(size: 18, weight: isHardSkillSet_Button ? .regular : .bold))
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
