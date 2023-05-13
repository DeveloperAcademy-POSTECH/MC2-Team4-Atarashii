//
//  InitialCardMainView.swift
//  bletest
//
//  Created by 황지우2 on 2023/05/08.
//

import SwiftUI

struct InitialCardNameView: View {
    @State var fontColor = #colorLiteral(red: 0.7878244519, green: 0.7844588161, blue: 0.7843878269, alpha: 1)
    @State var isButtonVisible: Bool = true
    @Binding var cardViewSelection: cardViewCategories
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .leading) { // Initial Card View
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color(strokeGray), lineWidth: 1)
                    .frame(width: 315, height: 490, alignment: .center)
                VStack(alignment: .leading, spacing: 46) {
                    
                    // MARK: - 뷰 카테고리에 대응해서 각기 다른 초기화면 메세지 띄우기
                    switch cardViewSelection {
                    case .myCard:
                        Text("지금, 당신만의\n아카데미 버츄얼 명함을\n만들어보세요!")
                            .font(.system(size: 23.51, weight: .bold))
                            .foregroundColor(Color(fontColor))
                        
                        if self.isButtonVisible == true {
                            NavigationLink {
                                IntroductionTextEditorView()
                            } label: {
                                HStack(spacing: 4.64) {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .frame(width: 17.17, height: 17.17)
                                        .foregroundColor(.white)
                                    Text("내 명함 만들러 가기")
                                        .font(.system(size: 14.42, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 18.16)
                                    .fill(Color(softPink))
                                    .frame(width: 168.41, height: 39)
                                
                            )
                            .padding(.leading, 15)
                        }
                        
                        
                    case .cardCollection:
                        Text("아직 내가 수집한 \n명함이 없어요 :(")
                            .font(.system(size: 23.51, weight: .bold))
                            .foregroundColor(Color(fontColor))
                    case .likedCards:
                        Text("아직 즐겨찾기한 \n명함이 없어요 :(")
                            .font(.system(size: 23.51, weight: .bold))
                            .foregroundColor(Color(fontColor))
                    }
                    
                }
                .padding(.leading, 22)
                
            }
            .padding(.top, -57)
        }
    }
}

//struct InitailCardMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        InitailCardMainView().previewDevice("iPhone 14")
//    }
//}
