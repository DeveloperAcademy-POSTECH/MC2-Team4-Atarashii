//
//  InitTimeView.swift
//  bletest
//
//  Created by 주환 on 2023/05/08.
//

import SwiftUI

struct CreateTimeView : View {
    @EnvironmentObject var user: userData
    
    let nickEnglish: String
    let nickKorean: String
    
    @State var isMorningFlag: Bool?
    
    var body: some View {
        VStack{
            Text("\(nickEnglish)의 세션 시간대를\n선택해주세요!")
                .bold()
                .font(.system(size: 25))
            
            HStack(spacing: 13) {
                CreateTimeBtn(isMorningFlag: $isMorningFlag, isTimeMorning: true)
                CreateTimeBtn(isMorningFlag: $isMorningFlag, isTimeMorning: false)
            }
            
            
            Button(action: {
                // DB Upload
                applyNickAndSession()
            }) {
                Text("입력 완료")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(width: 315, height: 52)
                    .background(isMorningFlag != nil ? .red : .gray)
                    .cornerRadius(10)
            }.disabled(isMorningFlag == nil)
            .padding()

        }
    }
    
        func applyNickAndSession(){
            db.collection("Users").document(user.id).setData([
                "nickEnglish": nickEnglish,
                "nickKorean": nickKorean,
                "isSessionMorning": isMorningFlag!,
                "cardCollectCount": 0
            ], merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err) - CreateTimeView")
                } else {
                    // db setdata 성공 시
                    print("User nickname and Session Time Successfully Saved : \(user.id) - CreateTimeView")
                    user.nickEnglish = nickEnglish
                    user.nickKorean = nickKorean
                    user.isSessionMorning = isMorningFlag!
                    UserDefaults().set(nickEnglish, forKey: "nickEnglish")
                    UserDefaults().set(nickKorean, forKey: "nickKorean")
                    UserDefaults().set(isMorningFlag, forKey: "isSessionMorning")
                }
            }
        }
    
}


struct CreateTimeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTimeView(nickEnglish: "Swimmer", nickKorean: "스위머").previewDevice("iPhone 14")
    }
}


struct CreateTimeBtn: View {
    @Binding var isMorningFlag: Bool?
    let isTimeMorning: Bool
    
    var isSelected: Bool {
        return isMorningFlag == isTimeMorning
    }
        
    var body: some View {
        Button {
            isMorningFlag = isTimeMorning
        } label: {
            VStack{
                Image(systemName: isSelected ? "clock": "clock.fill")
                    .resizable()
//                    .rotationEffect(timeText == "오후" ? Angle(degrees: 90): Angle(degrees: 0))
                    .renderingMode(.original)
                    .frame(width: 63,height: 63)
                Text(isTimeMorning ? "오전 세션" : "오후 세션")
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor(isSelected ? .black: .gray)
                // TODO : DB Fetching - user count.
                Text(isTimeMorning ? "현재 00명의 오전 세션 러너가\n 포켓러너와 함께하고 있어요!" : "현재 00명의 오후 세션 러너가\n 포켓러너와 함께하고 있어요!")
                    .font(.system(size: 9))
                    .foregroundColor(isSelected ? .black: .gray)
                    .padding(.vertical,10)
            }
            .frame(minWidth: 150,minHeight: 182)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: isSelected ? 30 : 0)
                    .animation(.easeIn, value: 0.2)
            }
        }
    }
}
