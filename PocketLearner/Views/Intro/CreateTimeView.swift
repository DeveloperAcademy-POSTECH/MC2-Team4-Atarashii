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
    
    @State var isFinish: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                Text("\(nickEnglish)의 세션 시간대를\n선택해주세요!")
                    .bold()
                    .font(.system(size: 25))
                    .padding(.bottom, 20)
                
                HStack(spacing: 13) {
                    CreateTimeBtn(isMorningFlag: $isMorningFlag, isTimeMorning: true)
                    CreateTimeBtn(isMorningFlag: $isMorningFlag, isTimeMorning: false)
                }
                
                
                Button(action: {
                    // DB Upload
                    isFinish = true
                }) {
                    Text("선택 완료")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(width: 315, height: 52)
                        .background(isMorningFlag != nil ? mainAccentColor : Color(buttonDisabledGrayColor))
                        .cornerRadius(10)
                }.disabled(isMorningFlag == nil)
                    .padding()
            }
            
 
            
            if isFinish {
                Color.gray.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                welcomeAlertView(onButtonTapped: applyNickAndSession)
            }
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
                Image(isTimeMorning ? (isSelected ? "morning_color": "morning_gray") : (isSelected ? "afternoon_color": "afternoon_gray"))
                    .resizable()
//                    .rotationEffect(timeText == "오후" ? Angle(degrees: 90): Angle(degrees: 0))
                    .renderingMode(.original)
                    .frame(width: 63,height: 63)
                Text(isTimeMorning ? "오전 세션" : "오후 세션")
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor(isSelected ? .black: .gray)
                // TODO: DB Fetching - user count.
//                Text(isTimeMorning ? "현재 00명의 오전 세션 러너가\n 포켓러너와 함께하고 있어요!" : "현재 00명의 오후 세션 러너가\n 포켓러너와 함께하고 있어요!")
//                    .font(.system(size: 9))
//                    .foregroundColor(isSelected ? .black: .gray)
//                    .padding(.vertical,10)
            }
            .frame(minWidth: 150,minHeight: 182)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.25), radius: isSelected ? 5.6 : 0)
                    .animation(.easeIn, value: 0.2)
            }
        }
    }
}
