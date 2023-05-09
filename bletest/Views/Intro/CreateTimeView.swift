//
//  InitTimeView.swift
//  bletest
//
//  Created by 주환 on 2023/05/08.
//

import SwiftUI

struct CreateTimeView : View {
    let englishName: String
    @State var am: Bool = false
    @State var pm: Bool = false
    
    var body: some View {
        VStack{
            Text("\(englishName)의 세션 시간대를\n선택해주세요!")
                .bold()
                .font(.system(size: 25))
            
            HStack(spacing: 1) {
                Button {
                    // 오전 선택시
                    pm = false
                    self.am.toggle()
                } label: {
                    if #available(iOS 15.0, *) {
                        VStack{
                            Image("dummyPikachu")
                                .resizable()
                                .foregroundColor(.red)
                                .colorMultiply(am ? .white:.gray)
                                .frame(width: 50,height: 50)
                            Text("오전 세션")
                                .font(.system(size: 15))
                                .bold()
                                .foregroundColor(.black)
                            Text("현재 00명의 오전세션 러너가\n (앱이름)과 함께하고 있어요!")
                                .font(.system(size: 9))
                                .foregroundColor(.black)
                                .padding(.vertical,10)
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(am ? Color.blue:Color.gray, lineWidth: am ? 10: 1)
                                .animation(.easeIn, value: 0.2)
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
                .frame(width: 150, height: 182)
                
                Button {
                    // 오후 선택시
                    am = false
                    self.pm.toggle()
                } label: {
                    if #available(iOS 15.0, *) {
                        VStack{
                            Image("dummyPikachu")
                                .resizable()
                                .foregroundColor(.red)
                                .colorMultiply(pm ? .white:.gray)
                                .frame(width: 50,height: 50)
                            Text("오후 세션")
                                .font(.system(size: 15))
                                .bold()
                                .foregroundColor(.black)
                            Text("현재 00명의 오후세션 러너가\n (앱이름)과 함께하고 있어요!")
                                .font(.system(size: 9))
                                .foregroundColor(.black)
                            
                                .padding(.vertical,10)
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(pm ? Color.blue:Color.gray, lineWidth: pm ? 10: 1)
                                .animation(.easeIn, value: 0.2)
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
                .frame(width: 150, height: 182)
                
            }
            
            
            Button(action: {
                // button action here
            }) {
                Text("입력 완료")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(width: 315, height: 52)
                    .background(am != pm ? Color.red : Color.gray)
                    .cornerRadius(10)
            }

        }
    }
    
}


struct CreateTimeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTimeView(englishName: "Swimmer").previewDevice("iPhone 14")
    }
}
