//
//  EditCardInfoView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI
import Photos

struct EditCardInfoView: View {
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ProfilePictureView()
                
                CharacterCountTextField(placeholder: "안녕하세요! 겉바속촉 디발자 리앤입니다!", limit: 50, height: 100)
            }
            
            VStack {
                Text("스킬관련 🛠️")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding()
                
                Text("나의 현재 스킬셋")
                    .bold()
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding()
                HStack(spacing: 7) {
                    skillIconView()
                    skillIconView()
                    skillIconView()
            }
                Text("추가 설명")
                    .padding(.bottom,-15)
                CharacterCountTextField(placeholder: "내가 가지고 있는 스킬셋에 대해 자세하게 서술해주세요!", limit: 100, height: 160)
            }
            
            VStack {
                Text("키우고 싶은 스킬셋")
                    .bold()
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding()
                
                HStack(spacing: 7) {
                    skillIconView()
                    skillIconView()
                    skillIconView()
                }
                
                Text("추가 설명")
                    .padding(.bottom,-15)
                
                CharacterCountTextField(placeholder: "내가 키우고 싶은 스킬셋에 대해 자세하게 서술해주세요!", limit: 100, height: 160)
            }
            
            VStack {
                Text("협업 관련 👥")
                    .padding()
                    .foregroundColor(.gray)
                    .bold()
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack {
                    Text("나의 협업 유형은")
                        .padding()
                        .bold()
                        .font(.system(size: 18))
                        .frame(minWidth: 130,alignment: .leading)

                    Button {
                        //
                    } label: {
                        Text("Driver")
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.up.chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing,150)

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
                            .foregroundColor(.gray)
                            .padding(.trailing,150)
                        Button {
                            
                        } label: {
                            VStack{
                                Text("공감능력")
                                    .foregroundColor(.gray)
                                Text("감성지능")
                                    .foregroundColor(.gray)
                                Text("유연한사고")
                                    .foregroundColor(.gray)
                            }
                            Image(systemName: "chevron.forward")
                                .padding(.top,-27)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading,130)
                    }

                }
                
            }
            
        }
    }
    
    func skillIconView() -> some View {
        ZStack{
            Text("UX 라이팅")
                .padding(.leading,20)
                .frame(maxWidth: 120,maxHeight: 40,alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                }
                Button  {
                    //
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                }.padding(.leading,90)
        }

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
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 10)
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            
            
            
            Button(action: {
                self.isShowingImagePicker = true
            }) {
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .foregroundColor(.gray)
            }
            .padding(.top,-35)
            .padding(.leading,75)
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
    @State private var text = ""
    let placeholder: String
    let limit: Int
    let height: CGFloat
    
    var body: some View {
        VStack {
            TextField("\(placeholder)", text: $text)
                .disabled(text.count >= limit)
                .padding()
                .frame(maxWidth: .infinity,minHeight: height)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                )
            
            Text("\(limit - text.count) characters remaining")
                .foregroundColor(text.count > limit ? .red : .gray)
                .font(.caption)
                .padding(.top, -25)
                .padding(.trailing,-300)
        }
        .padding()
    }
}


