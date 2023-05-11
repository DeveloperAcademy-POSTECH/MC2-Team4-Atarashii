


import SwiftUI

struct SelectRoleGoalView: View {
    @State var activatedCircleNumber: Int = 3
    @State var headerTitleMessage: String = "아카데미에서 어떤 목표를 그리고 있나요?"
    @State var isHeaderDescriptionVisible: Bool = false
//    @State var pickerChosenText = "iOS 개발자"
//    @State var pickerAccentColor = pickerEmptyGray
    
    // Picker 관련
    
    //show and hide 드롭다운메뉴
    @State private var isOptionsPresented: Bool = false
    @State var selectedOption : GoalOption? = nil  // 나중에 옵션 번호로 변경
    // bind user selection
    //dropdown의 placeholder
    let placeHolder: String = "내 목표 선택"
    
    // Sheet 관련
    @State var showingSheet = false
    @State var sheetUserInputText = ""
    
    var body: some View {
        VStack(spacing: 0){
            CardGenerateViewHeader(activatedCircleNumber: activatedCircleNumber, headerTitleMessage: headerTitleMessage, isHeaderDescriptionVisible: isHeaderDescriptionVisible)
            
            ZStack {
                ZStack(alignment: .leading) { // 카드 내부 뷰
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color(strokeGray), lineWidth: 1)
                    .frame(width: 315, height: 430, alignment: .center)
                    
                    VStack(alignment: .leading) { // 내부 텍스트 + Dropdown 버튼 스택뷰
                        Text("나는\n아카데미에서의\n팀 협업을 통해")
                            .font(.system(size: 27, weight: .regular))
                            .lineSpacing(10)
                        
                        HStack { // Dropdown버튼 + 로서
                            // Dropdown 버튼
                            Button(action: {

                                withAnimation{
                                    self.isOptionsPresented.toggle()
                                }

                            }){
                                HStack(spacing: 15.43) {
                                    Text(
                                        //🔴 텍스트 로직 바꾸기 - 삼항연산자로 분기
                                        
                                        // SelectedOption이 nil일 경우 => self.placeHolder
                                        // SelectedOptin이 nil이 아닐 경우
                                            // => selectedOption?.title ?? " "
                                            // SelectedOption이 직접입력이고, sheetUserInputText가 있을 경우
                                               // => sheetUserInputText
                                            
                                        selectedOption != nil ? (selectedOption!.title=="직접 입력" && sheetUserInputText.isEmpty==false ? sheetUserInputText : selectedOption?.title ?? " ") : self.placeHolder
                                            
                                    )
                                            .font(.system(size:22, weight: .light))
                                            .foregroundColor(selectedOption != nil ? mainAccentColor : .gray)
                                            .multilineTextAlignment(.leading)

                                        Image(systemName: self.isOptionsPresented ? "chevron.up.circle" : "chevron.down.circle")
                                            .font(.system(size:22, weight: .regular))
                                            .foregroundColor(selectedOption != nil ? mainAccentColor : pickerEmptyGray)

                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 7)
                                    .background(
                                        
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(selectedOption != nil ? mainAccentColor : pickerEmptyGray, lineWidth: 2)
                                            .frame(maxHeight: 100)
                                    
                                    )
                                    .frame(maxWidth: 251, alignment: .leading)
                                    .padding(.vertical, 7)
    //                                .overlay(alignment: .top){
    //                                        VStack{
    //                                            if self.isOptionsPresented {
    //
    //                                                //⭐️여기에 드롭다운 메뉴 옵션 리스트
    //                                                Spacer(minLength: 10)
    //                                                GoalPickerMenuList { option in
    //                                                    isOptionsPresented = false
    //                                                    selectedOption = option
    //                                                }
    //
    //
    //
    //                                            }
    //                                    }
    //                                }

                            }
                            
                           
                        }
                        Text("로서 성장하고 싶어요")
                            .font(.system(size: 27, weight: .regular))
                    }
                    .padding(.leading,32)
                }
                .padding(.top, 45)
                
                // 피커 trial2
                if self.isOptionsPresented {
                    GoalPickerMenuList { option in
                        isOptionsPresented = false
                        selectedOption = option
                        if selectedOption!.title == "직접 입력" {
                            showingSheet.toggle()
                        }
                    }
                    .padding(.leading, 70)
                    .padding(.trailing, 150)
                    .offset(y: 180)
                }
                
            }
            cardGenerateViewsButton(title:"다음", disableCondition: self.selectedOption == nil, action: {})
            .padding(.top, 45)
        }
        // Sheet Open
        .sheet(isPresented: $showingSheet) {
            RoleGoalInputSheetView(sendInputText: $sheetUserInputText)
                .presentationDetents([.height(217)])
                .presentationDragIndicator(.hidden)
        }
    }
}








struct SelectRoleGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRoleGoalView().previewDevice("iPhone 14")
    }
}
