//
//  InitailCardMainView.swift
//  bletest
//
//  Created by 황지우2 on 2023/05/08.
//

import SwiftUI

struct InitailCardMainView: View {
    let strokeGray = #colorLiteral(red: 0.8537765145, green: 0.8537764549, blue: 0.8537764549, alpha: 1)
    let softPink = #colorLiteral(red: 0.9706365466, green: 0.7397540212, blue: 0.753657043, alpha: 1)
    @State var fontColor = #colorLiteral(red: 0.7878244519, green: 0.7844588161, blue: 0.7843878269, alpha: 1)
    @State var title: String = "지금, 당신만의\n아카데미 버츄얼 명함을\n만들어보세요!"
    @State var isButtonVisible: Bool = true
    var body: some View {
        VStack(spacing: 49){
            Spacer()
            ZStack(alignment: .leading){ // Initial Card View
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color(strokeGray), lineWidth: 1)
                    .frame(width: 315, height: 490, alignment: .center)
                VStack(alignment: .leading, spacing: 46) {
                    Text(title)
                        .font(.system(size: 23.51, weight: .bold))
                        .foregroundColor(Color(fontColor))
                    // 나중에 Navigation Link로 전환 요망
                    if self.isButtonVisible == true {
                        Button(action: {
                            // action
                        }
                        ){
                            HStack(spacing: 4.64){
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 17.17, height: 17.17)
                                    .foregroundColor(.white)
                                Text("내 명함 만들러 가기")
                                    .font(.system(size: 14.42, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 18.16)
                                    .fill(Color(softPink))
                                    .frame(width: 168.41, height: 39)
      
                            )
                            .padding(.leading, 15)
                        }
                    }
                    
                }
                .padding(.leading, 33)
                

            }
        }
        .padding(.top, 93 - 47)
        .padding(.bottom, 163 - 34)
        .padding(.horizontal, 37)
    }
}

struct InitailCardMainView_Previews: PreviewProvider {
    static var previews: some View {
        InitailCardMainView().previewDevice("iPhone 14")
    }
}
