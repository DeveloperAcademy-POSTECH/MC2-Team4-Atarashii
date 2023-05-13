//
//  CardGenerateTextEditorView.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/10.
//

import SwiftUI

struct CardGenerateTextEditorView: View {
    @State var inputText : String = ""
    @State var activatedCircleNumber: Int = 1
    @State var headerTitleMessage: String = "나를 소개하는\n한문장을 적어주세요!"
    @State var isHeaderDescriptionVisible: Bool = false
    @State var headerDescriptionMessage: String = "우리 모두는 주어진 예시 외에도, 다양한 스킬을 가지고 있을 수 있어요.\n원하는 보기가 없다면 당신만의 스킬 키워드를 직접 입력해주세요!"
    @State var placeHolder: String = "나를 가장 잘 표현할 수 있는 문장을\n50자 이내로 작성해주세요."
    @State var letterLimit:Int = 150
    
    @State var goNext: Bool = false
    
    var body: some View {
        VStack(spacing: 34) {
            VStack(alignment: .trailing){ // 상단버튼 + 헤더뷰
                //                Button(action: {}){ // 후에 NavigationLink로 코드 수정 요망.
                //                    Text("나중에 적을래요")
                //                        .foregroundColor(Color("mainAccentColor"))
                //                        .font(.system(size: 17, weight: .semibold))
                //                        .padding(.trailing, 27)
                //                }
                // 뷰의 조건에 맞는 헤더 입력.
                CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, isHeaderDescriptionVisible: isHeaderDescriptionVisible, headerDescriptionMessage: headerTitleMessage)
            }
            VStack { // 텍스트에디터 + 하단 버튼
                letterLimitTextField(placeholder: placeHolder, commentText: $inputText, letterLimit: letterLimit)
                    .padding(.top, 14)
                    .padding(.horizontal, 37)
                
                cardGenerateViewsButton(title:"다음", disableCondition: self.inputText.count == 0, action: {
                    goNext = true
                }).padding(.top, 20)
                    .navigationDestination(isPresented: $goNext){
                        SelectRoleGoalView()
                    }
            }
                
                Spacer()
            }
            .onTapGesture {
                UtilFunction.noKeyboard()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        goNext = true
                    }){
                        Text("나중에 적을래요")
                            .foregroundColor(Color("mainAccentColor"))
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.trailing, 5)
                    }
                }
            }
        }
    }
    
    struct CardGenerateTextEditorView_Previews: PreviewProvider {
        static var previews: some View {
            CardGenerateTextEditorView().previewDevice("iPhone 14")
        }
    }
