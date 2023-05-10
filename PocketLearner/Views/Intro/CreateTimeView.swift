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
            
            HStack(spacing: 13) {
                CreateTimeBtn(isSelected: $am, timeText: "오전")
                CreateTimeBtn(isSelected: $pm, timeText: "오후")
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
            .padding()

        }
    }
    
}


struct CreateTimeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTimeView(englishName: "Swimmer").previewDevice("iPhone 14")
    }
}


struct CreateTimeBtn: View {
    @Binding var isSelected: Bool
    let timeText: String
    
    var body: some View {
        Button {
            self.isSelected.toggle()
        } label: {
            VStack{
                Image(systemName: isSelected ? "clock": "clock.fill")
                    .resizable()
//                    .rotationEffect(timeText == "오후" ? Angle(degrees: 90): Angle(degrees: 0))
                    .renderingMode(.original)
                    .frame(width: 63,height: 63)
                Text("\(timeText) 세션")
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor(isSelected ? .black:.gray)
                Text("현재 00명의 \(timeText)세션 러너가\n (앱이름)과 함께하고 있어요!")
                    .font(.system(size: 9))
                    .foregroundColor(isSelected ? .black:.gray)
                    .padding(.vertical,10)
            }
            .frame(minWidth: 150,minHeight: 182)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 30)
                    .animation(.easeIn, value: 0.2)
            }
            
        }
    }
}
