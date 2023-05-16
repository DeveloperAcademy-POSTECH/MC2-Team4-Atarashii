//
//  MainView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/11.
//
import SwiftUI



struct MainView: View {
    @EnvironmentObject var user : userData
    @EnvironmentObject var card : CardDetailData
    
    @State var isSplash: Bool = true
    
    var body: some View {
        ZStack{
            if user.AppleID == "" {
                AppleLoginView()
            } else if user.nickEnglish == "" {
                // 닉네임 설정 후 세션 설정을 했더라도, 그냥 다시 닉네임 설정 뷰로 돌아오게 함.
                CreateNickNameView()
            } else {
                MainTabView().environmentObject(user).environmentObject(card).task {
                    loadUserData()
                    loadCardDetailData()
                }
            }
            
            if isSplash {
                Image("splash")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation (.easeIn(duration: 1.5)){
                    isSplash = false
                }
            }
        }
    }
    
    func loadUserData(){
        print("Load User Data... \(user.id)")
        let userDocRef = db.collection("Users").document(user.id)
        
        userDocRef.getDocument() { (document, error) in
            if let document = document {
                let data = document.data()
                //---
                user.id = data?["id"] as? String ?? ""
                user.nickEnglish = data?["nickEnglish"] as? String ?? ""
                user.nickKorean = data?["nickKorean"] as? String ?? ""
                user.isSessionMorning = data?["isSessionMorning"] as? Bool ?? false
                user.cardCollectCount = data?["cardCollectCount"] as? Int ?? 0
                
                if let err = error{
                    print("Error getting Card Detail Data - MainView: \(err)")
                }
            } else {
                print("Card Detail Data doesn't Exist - MainView")
            }
        }
    }
    
    func loadCardDetailData(){
        print("Load Card Detail Data... \(user.id)")
        let cardDetailDocRef = db.collection("CardDetails").document(user.id)
        
        cardDetailDocRef.getDocument() { (document, error) in
            if let document = document {
                let data = document.data()
                card.introduce = data?["introduce"] as? String ?? ""
                card.skills = data?["skills"] as? [String] ?? []
                card.skillLevel = data?["skillLevel"] as? [Int] ?? []
                card.introduceSkill = data?["introduceSkill"] as? String ?? ""
                card.growthTarget = data?["growthTarget"] as? String ?? ""
                card.wishSkills = data?["wishSkills"] as? [String] ?? []
                card.wishSkillIntroduce = data?["wishSkillIntroduce"] as? String ?? ""
                card.communicationType = data?["communicationType"] as? Int ?? 0
                card.cooperationKeywords = data?["cooperationKeywords"] as? [Bool] ?? []
                card.cooperationIntroduce = data?["cooperationIntroduce"] as? String ?? ""
                card.cardColor = data?["cardColor"] as? Int ?? 0
                card.cardPattern = data?["cardPattern"] as? Int ?? 0
                card.memoji = data?["memoji"] as? String ?? ""
                //---
                card.id = data?["id"] as? String ?? ""
                card.nickEnglish = data?["nickEnglish"] as? String ?? ""
                card.nickKorean = data?["nickKorean"] as? String ?? ""
                card.isSessionMorning = data?["isSessionMorning"] as? Bool ?? false
                
                if let err = error{
                    print("Error getting Card Detail Data - MainView: \(err)")
                }
            } else {
                print("Card Detail Data doesn't Exist - MainView")
            }
        }
        
    }
}
