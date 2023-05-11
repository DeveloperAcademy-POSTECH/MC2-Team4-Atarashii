//
//  EditCardDesignView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI
import UIKit



// MARK: - 명함 패턴을 나타내는 아이콘
enum cardPatternIconList: String, CaseIterable {
    case sunny = "sun.max.fill"
    case floral = "camera.macro"
    case bubble = "bubbles.and.sparkles.fill"
    case beach = "applelogo"
    case heart = "smiley.fill"
    case space = "0.circle.fill.ar"
}

// MARK: - 명함 패턴 값
enum cardPatternList: String, CaseIterable {
    case sunny = "dummyPattern1"
    case floral = "dummyPattern2"
    case bubble = "dummypikachu"
    case beach = "dummyPattern3"
    case heart = "dummyPattern4"
    case space = "dummyPattern5"
}


struct EditCardDesignView: View {
    
    @State private var customSelection: cardCustomCategories = .cardColor
    @State private var colorSelection: Color = purpleColor1
    @State private var patternSelection: cardPatternIconList = .sunny
    
    /// DATA:
    let userInfo: UserInfo
    
    // MARK: - 임시 명함 컬러 값
    /// default 브랜드 컬러 값
    let cardColorList: [Color] = [
        purpleColor1, textPinkColor, purpleColor1, textPinkColor, purpleColor2, textPinkColor, purpleColor1, purpleColor2
    ]
    
    // MARK: - LazyGrid용 변수
    var colorColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    var patternColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
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
            CustomCardTemplate(userInfo: userInfo, colorSelection: $colorSelection, patternSelection: $patternSelection)
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
                    
                    
                    VStack {
                        switch customSelection {
                            // MARK: - 명함 컬러 섹션
                        case .cardColor:
                            LazyVGrid(columns: colorColumns) {
                                ForEach(0..<cardColorList.count, id: \.self) { index in
                                    Button {
                                        /// 선택된 컬러 값 할당
                                        colorSelection = cardColorList[index]
                                        /// TODO: 선택된 컬러 값 파베에 Update
                                        
                                    } label: {
                                        Circle()
                                            .foregroundColor(cardColorList[index])
                                            .frame(width: 54)
                                            .padding(.bottom, 15)
                                    }
                                }
                            }
                            // MARK: - 명함 컬러 섹션
                        case .cardPattern:
                            LazyVGrid(columns: patternColumns) {
                                ForEach(cardPatternIconList.allCases, id: \.self) { item in
                                    Button {
                                        /// 선택된 패턴 값 할당
                                        patternSelection = item
                                        /// TODO: 선택된 패턴 값 파베에 Update
                                        print("hehe")
                                        
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .fill(.gray.opacity(0.1))
                                                .frame(width: 54)
                                            Image(systemName: "\(item.rawValue)")
                                                .frame(width: 54)
                                        }
                                        .padding(.bottom, 15)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 38)
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
    
    let emojiTextFieldLimit = 1
    let userInfo: UserInfo

    @State private var emojiInput: String = ""
    
    //    @State var uiImage = UIImage(named: "myImage")
     
    @Binding var colorSelection: Color
    @Binding var patternSelection: cardPatternIconList
    
    var body: some View {
        ZStack {
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
            }
            .frame(height: 490)
            /// TODO: 컬러 extension 추가 후 적용
            .background(colorSelection)
            .cornerRadius(32)
            
            
            
            // MARK: - 선택된 패턴 overlay
            VStack {
                switch patternSelection {
                case .sunny:
                    Image("\(cardPatternList.sunny.rawValue)")
                        .cornerRadius(32)
                        .blendMode(.overlay)
                        .opacity(0.6)
                case .floral:
                    Image("\(cardPatternList.floral.rawValue)")
                        .cornerRadius(32)
                        .blendMode(.overlay)
                        .opacity(0.6)
                case .bubble:
                    Image("\(cardPatternList.bubble.rawValue)")
                        .cornerRadius(32)
                        .blendMode(.overlay)
                        .opacity(0.6)
                case .beach:
                    Image("\(cardPatternList.beach.rawValue)")
                        .cornerRadius(32)
                        .blendMode(.overlay)
                        .opacity(0.6)
                case .heart:
                    Image("\(cardPatternList.heart.rawValue)")
                        .cornerRadius(32)
                        .blendMode(.overlay)
                        .opacity(0.6)
                case .space:
                    Image("\(cardPatternList.space.rawValue)")
                        .cornerRadius(32)
                        .blendMode(.overlay)
                        .opacity(0.6)
                }
            
            }
            .frame(height: 490)
            .cornerRadius(32)
            
            
            // MARK: - 미모지 추가 영역
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    // MARK: - 이모지 아바타 이미지 (임시방편)
                    ZStack(alignment: .center) {
                        HStack {
                            Spacer()
                            Circle()
                                .frame(width: 100)
                                .foregroundColor(gaugeGrayColor)
                        }
                        HStack {
                            Spacer()
                            EmojiTextField(text: $emojiInput, placeholder: "")
                                .frame(width: 40, height: nil)
                                .scaleEffect(3)
                                .padding(.all, 5)
                                .onChange(of: emojiInput) { _ in
                                    emojiInput = String(emojiInput.prefix(emojiTextFieldLimit))
                                }
                        }
                        
                        if !emojiInput.containsEmoji {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 40))
                                .foregroundColor(.gray.opacity(0.4))
                                .offset(x: 84)
                        }
                    }
                    .offset(y: 163)
                    
                    // MARK: - 미모지 아바타 이미지
                    /// UIKit으로된 MemojiView 코드 사용
//                    ConvertedMemojiView()
//                        .frame(width: 100, height: 100)
//                        .onTapGesture {
//                            /// 키보드 dismiss를 위한 메서드 - 작동이 안먹히는듯..
//                            hideKeyboard()
//                        }
  
                }
                .padding(22)
            }
            .frame(height: 490)
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
