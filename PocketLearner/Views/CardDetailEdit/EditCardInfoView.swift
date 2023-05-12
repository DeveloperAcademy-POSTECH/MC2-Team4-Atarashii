//
//  EditCardInfoView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI
import Photos

struct EditCardInfoView: View {
    @State var isSheet: Bool = false
    @State var myGoal: String = ""

    @State var isPresent: Bool = false
    var body: some View {
        ScrollView(.vertical) {
            DetailEditProfileView()
            DetailEditSkillView()
            HStack {
                Text("아카데미에서의 성장목표")
                
                Menu(content: {
                    Button("PM", action: handlePmSet)
                    Button("iOS 개발자", action: handleIosSet)
                    Button("서버 개발자", action: handleServerSet)
                    Button("UI/UX 디자이너", action: handleUiandUxSet)
                    Button("기타", action: handleOtherSet)
                }, label: {
                    Text("\(myGoal)")
                        .foregroundColor(hexStringToColor(hexString: "#979797"))
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(hexStringToColor(hexString: "#979797"))
                })
            }
            
            .sheet(isPresented: $isSheet) {
                RoleGoalInputSheetView(sendInputText: $myGoal)
                
                    .sheet(isPresented: $isPresent) {
                        /*
                         RoleGoalInputSheetView(textFieldText: $myGoalText)
                         */
                        
                    }
                DetailEditCollaborationView()
            }
        }
    }
    
    
    func handlePmSet() {
        self.myGoal = "PM"
    }
    func handleIosSet() {
        self.myGoal = "iOS 개발자"
    }
    func handleServerSet() {
        self.myGoal = "서버 개발자"
    }
    func handleUiandUxSet() {
        self.myGoal = "UI/UX 디자이너"
    }
    func handleOtherSet() {
        self.isSheet = true
    }
    
}

struct EditCardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardInfoView()
    }
}

struct ProfilePictureView: View {
    
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: UIImage?
    
    var body: some View {
        VStack {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 190, height: 190)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 10)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 190, height: 190)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .foregroundColor(.white)
            }
            
            
            
            Button(action: {
                self.isShowingImagePicker = true
            }) {
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundColor(hexStringToColor(hexString: "#FFA04B"))
            }
            .padding(.top,-50)
            .padding(.leading,130)
            .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: self.$selectedImage)
            }
        }
    }
    
    private func loadImage() {
        guard let selectedImage = selectedImage else { return }
        self.profileImage = selectedImage
    }
    
}

struct CharacterCountTextField: View {
    @Binding var text: String
    let placeholder: String
    let limit: Int
    let height: CGFloat
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .lineLimit(Int(limit/20), reservesSpace: true)
//                .disabled(text.count >= limit)
                .padding()
                .frame(maxWidth: .infinity,minHeight: height)
                .multilineTextAlignment(.leading)
                .onReceive($text.wrappedValue.publisher.collect()) {
                    $text.wrappedValue = String($0.prefix(limit))
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(hexStringToColor(hexString: "#D8D8D8"), lineWidth: 2)
                )
                
            
            Text("\(text.count) / \(limit) 자")
                .foregroundColor(text.count > limit ? .red : .gray)
                .font(.caption)
                .padding(.top, -25)
                .padding(.leading,270)
            
            
        }
        .padding()
    }
}

struct DetailEditProfileView: View {
    @State var discriptionText: String = ""
    
    var body: some View {
        VStack {
            ProfilePictureView()
            
            CharacterCountTextField(text: $discriptionText, placeholder: "안녕하세요! 겉바속촉 디발자 리앤입니다!", limit: 50, height: 100)
        }
    }
}

struct DetailEditSkillView: View {
    @State var mySkillText: String = ""
    @State var myFutureSkillText: String = ""
    var body: some View {
        VStack {
            Text("스킬관련 🛠️")
                .foregroundColor(hexStringToColor(hexString: "#979797"))
                .bold()
                .font(.system(size: 24))
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            
            Text("나의 현재 스킬셋")
                .bold()
                .font(.system(size: 18))
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            
            HStack(spacing: 10) {
                skillIconView()
                skillIconView()
                skillIconView()
            }
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("스킬셋 변경")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .frame(minWidth: 88.5,minHeight: 18)
                .padding()

            }
            Text("추가 설명")
                .frame(maxWidth: .infinity,alignment: .leading)
                .bold()
                .font(.system(size: 13))
                .padding(.bottom,-15)
                .padding(.leading)
            CharacterCountTextField(text: $mySkillText, placeholder: "내가 가지고 있는 스킬셋에 대해 자세하게 서술해주세요!", limit: 100, height: 160)
        }
        
        VStack {
            Text("키우고 싶은 스킬셋")
                .bold()
                .font(.system(size: 18))
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            
            HStack(spacing: 10) {
                skillIconView()
                skillIconView()
                skillIconView()
            }
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Text("스킬셋 변경")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .frame(minWidth: 88.5,minHeight: 18)
                .padding()

            }
            
            Text("추가 설명")
                .frame(maxWidth: .infinity,alignment: .leading)
                .bold()
                .font(.system(size: 13))
                .padding(.bottom,-15)
                .padding(.leading)
            
            CharacterCountTextField(text: $myFutureSkillText, placeholder: "내가 키우고 싶은 스킬셋에 대해 자세하게 서술해주세요!", limit: 100, height: 160)
        }
    }
    
    func skillIconView() -> some View {
        HStack {
            Text("UX 라이팅")
                .font(.system(size: 15))
                .padding(.leading,20)
                .frame(minWidth: 107,minHeight: 30,alignment: .leading)
            
            Button  {
                //
            } label: {
                Image(systemName: "x.circle.fill")
                    .foregroundColor(hexStringToColor(hexString: "#979797"))
            }
            .padding(.trailing,40)
            .frame(minWidth: 14,minHeight: 14)
        }
        .frame(width: 107,height: 30)
        .background {
            RoundedRectangle(cornerRadius: 35)
                .stroke()
        }
        
    }
}

//Collaboration
struct DetailEditCollaborationView: View {
    @State var discriptionText: String = ""
    @State var collaborationTypes:String = "Driver"
    
    var body: some View {
        VStack {
            Text("협업 관련 👥")
                .padding()
                .foregroundColor(hexStringToColor(hexString: "#979797"))
                .bold()
                .font(.system(size: 24))
                .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack {
                Text("나의 협업 유형은")
                    .padding(.leading,22)
                    .bold()
                    .font(.system(size: 18))
                    .frame(minWidth: 130,alignment: .leading)
                
                Menu(content: {
                    Button("Driver", action: handleDriverSet)
                    Button("Analytical", action: handleAnalyticalSet)
                    Button("Amiable", action: handleAmiableSet)
                    Button("Expressive", action: handleExpressiveSet)
                }, label: {
                    Text("\(collaborationTypes)")
                        .foregroundColor(hexStringToColor(hexString: "#979797"))
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(hexStringToColor(hexString: "#979797"))
                })
                   
                Spacer()
                
                
            }
            
            HStack {
                Text("나의 협업 키워드")
                    .padding()
                    .bold()
                    .font(.system(size: 18))
                    .frame(minWidth: 130,alignment: .leading)
                    .padding(.leading,7)
                Spacer()
                ZStack {
                    Text("(3개 선택)")
                        .foregroundColor(hexStringToColor(hexString: "#979797"))
                        .padding(.trailing,157)
                    Button {
                        
                    } label: {
                        VStack(alignment: .leading){
                            Text("공감능력")
                                .font(.system(size: 15))
                                .foregroundColor(hexStringToColor(hexString: "#979797"))
                            Text("감성지능")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                            Text("유연한사고")
                                .foregroundColor(hexStringToColor(hexString: "#979797"))
                                .font(.system(size: 15))
                        }
                        Image(systemName: "chevron.forward")
                            .padding(.top,-27)
                            .foregroundColor(hexStringToColor(hexString: "#979797"))
                    }
                    .padding(.trailing,12)
                    .padding(.leading,130)
                }
                
            }
            
        }
    }
    
    func handleDriverSet() {
        self.collaborationTypes = "Driver"
    }
    func handleAnalyticalSet() {
        self.collaborationTypes = "Analytical"
    }
    func handleAmiableSet() {
        self.collaborationTypes = "Amiable"
    }
    func handleExpressiveSet() {
        self.collaborationTypes = "Expressive"
    }

}
