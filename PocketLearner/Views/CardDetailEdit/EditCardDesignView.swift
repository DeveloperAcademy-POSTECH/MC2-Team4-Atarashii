//
//  EditCardDesignView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI
import UIKit

struct EditCardDesignView: View {
    
    @State var customSelection: cardCustomCategories = .cardColor
    
    let userInfo: UserInfo
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    
    // MARK: - 커스텀 카테고리
    enum cardCustomCategories: String, CaseIterable {
        case cardColor = "명함 컬러"
        case cardPattern = "명함 패턴"
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            
            // MARK: - 카드 뷰
            /// 여기서는 CardTemplate와 프로필을 조금 다르게 보여줘야 해서 뷰를 재사용하지 않고 커스텀 뷰에서만 쓰이는 틀을 새롭게 구현하는 것으로 결정.
            CustomCardTemplate(userInfo: userInfo)
                .scaleEffect(0.8)
                .frame(width: 300, height: 250)
            
            Spacer()
            
            // MARK: - 커스텀 창
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(23)
                    .shadow(color: Color.black.opacity(0.1), radius: 10)
                    .ignoresSafeArea()
                
                VStack {
                    // MARK: - 커스텀 창 Segmented Control
                    Picker("", selection: $customSelection) {
                        ForEach(cardCustomCategories.allCases, id: \.self) { category in
                            Text(category.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(50)
                    
                    // MARK: - 명함 컬러 섹션
                    
                    VStack {
                        LazyVGrid(columns: columns) {
                            ForEach((0..<8), id: \.self) { _ in
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 54)
                                    .padding(.bottom, 15)
                            }
                        }
                        
                    }
                    .padding(.horizontal, 35)
                    .padding(.top, -10)
                    
                    
                    Spacer()
                }
                
            }
            .frame(height: 300)
            
        }
    }
}





// MARK: - EditCardDesignView에서만 쓰이는 CardTemplate
/// CardTemplate + MemojiView
struct CustomCardTemplate: View {
    
    let userInfo: UserInfo
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack {
                    
                    // MARK: - 오전/오후 세션 태그
                    HStack {
                        Image(systemName: "\(userInfo.isMorningSession ? "sun.and.horizon" : "sun.max")")
                        Text("\(userInfo.isMorningSession ? "오전" : "오후")")
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(22)
                    
                    Spacer()
                }
                
                // MARK: - 국문 닉네임
                Text("\(userInfo.nicknameKOR)")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .padding(.top, 80)
                
                // MARK: - 영문 닉네임
                Text("\(userInfo.nicknameENG)")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding(.bottom, 12)
                
                // MARK: - 자기 소개
                Text("\(userInfo.selfDescription)")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 20))
            }
            .padding(22)
            
            Spacer()
            
            HStack {
                
                Spacer()
                
                // MARK: - 미모지 아바타 이미지
                /// UIKit으로된 MemojiView 코드 사용
                ConvertedMemojiView()
                    .frame(width: 100, height: 100)
                    .focused($isFocused)
                    .onTapGesture {
                        /// 키보드 dismiss를 위한 메서드 - 작동이 안먹히는듯..
                        hideKeyboard()
                    }
            }
            .padding(22)
            
        }
        .frame(height: 490)
        /// TODO: 컬러 extension 추가 후 적용
        .background(Color("\(userInfo.cardColor)"))
        .cornerRadius(32)
    }
}





// MARK: - MemojiView SwiftUI에서 사용하기
/// UIViewRepresentable: UIKit view를 SwiftUI에서 사용할 수 있도록 wrapping 해주는 프로토콜
struct ConvertedMemojiView: UIViewRepresentable {
    
    // MARK: - makeUIView(context:) -> UIView
    /// UIView 생성 및 초기화
    /// 생성한 UIView를 SwiftUI의 View로 래핑
    func makeUIView(context: Context) -> UIView {
        let memojiView = MemojiView(frame: .zero)
        memojiView.tintColor = .white
        return memojiView
    }
    
    // MARK: - updateUIView(:context:)
    /// view의 정보를 업데이트
    /// SwiftUI View의 state가 바뀔 때마다 트리거
    /// @Binding을 통해 SwiftUI View의 상태를 read-only로 가져올 수 있음
    func updateUIView(_ uiView: UIView, context: Context) {
        let memojiView = MemojiView(frame: .zero)
        memojiView.onChange = { image, imageType in
            print(imageType)// Do something on image change
        }
    }
}




struct EditCardDesignView_Previews: PreviewProvider {
    @Binding var isMine: Bool
    static var previews: some View {
        EditCardDesignView(userInfo: UserInfo(id: "", nicknameKOR: "리앤", nicknameENG: "Lianne", isMorningSession: true, selfDescription: "다재다능한 디발자가 꿈⭐️🐠🐶 개자이너 아니고 디발자요!", cardColor: "mainPurple"))
    }
}




// MARK: - keyboard dissmis 메서드
extension View {
  func hideKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
