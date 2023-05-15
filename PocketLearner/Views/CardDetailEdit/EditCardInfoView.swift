//
//  EditCardInfoView.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//



import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

//MARK: Main
struct EditCardInfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var card: CardDetailData
    @EnvironmentObject var user: userData
    
    
    // MARK: - 이미지 받아오기(PhotoURL)
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var image: String = ""
    @State private var profileImage: UIImage?
    @State var selectedImage: UIImage?
    
    @Binding var retrievedImage: UIImage
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                DetailEditProfileView(selectedImage: $selectedImage, retrievedImage: $retrievedImage)
                    .environmentObject(user)
                
                DetailEditSkillView()
                    .padding(.top,20)
                
                DetailEditMyGoal()
                
                DetailEditCollaborationView()
            }
            .onAppear {
                    retrievePhotos()
            }
        }
        .toolbar {
            Button {
                handleUpdateCardDetailData(profileImage: profileImage)
            } label: {
                Text("저장")
            }
            
        }
    }
    

    
    func handleUpdateCardDetailData(profileImage: UIImage?) {

        let washingtonRef = db.collection("CardDetails").document(user.id)
        
        washingtonRef.updateData([
            "introduce": card.introduce,
            "skills": card.skills,
            "skillLevel": card.skillLevel,
            "introduceSkill": card.introduceSkill,
            "growthTarget": card.growthTarget,
            "wishSkills": card.wishSkills,
            "wishSkillIntroduce": card.wishSkillIntroduce,
            "communicationType": card.communicationType,
            "cooperationKeywords": card.cooperationKeywords,
            "cooperationIntroduce": card.cooperationIntroduce,
            "memoji": card.memoji
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
            
            uploadPhoto(selectedImage: selectedImage)
            
            dismiss()
        }
    }
    
    // MARK: - Storage: uploadPhoto() (Method)
    /// Storage에 이미지 url 업로드 하기
    func uploadPhoto(selectedImage: UIImage?) {
        
        // Make sure that the selected image property isn't nil
        guard selectedImage != nil else {
            return
        }
        
        // Create storage reference
        let storageRef = Storage.storage().reference()
        
        // Turn our image into data
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        
        // Check that we were able to convert it to data
        guard imageData != nil else {
            return
        }
        
        // Specify the file path and name
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        print("UPDATE_PATH: ", path)
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            // Check for errors
            if error == nil && metadata != nil {
                
                // Save a reference to the file in Firestore DB
                let db = db.collection("CardDetails").document(user.id)
                db.updateData(["memoji":path]) { error in
                    
                    // if there were no errors, display the new image
//                    if error == nil {
//                        DispatchQueue.main.async {
//                            self.retrievePhotos()
//                        }
//                    }
                }
                    card.memoji = path
            }
        }
    }
    
    // MARK: - Storage: retrievePhotos() (Method)
    /// Storage에서 이미지 가져오기
    func retrievePhotos() {
        
        // Get the data from the database
        let docRef = Firestore.firestore().collection("CardDetails").document(user.id)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let imagePath = document.get("memoji")
                print(imagePath ?? "")
                
                // Get a reference to storage
                let storageRef = Storage.storage().reference()
                
                // Specify the path
                let fileRef = storageRef.child(imagePath as! String)
                
                // Retrieve the data
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    
                    // Check for errors
                    if error == nil && data != nil {
                       
                        // Create a UIImage and put it into display
                        if let image = UIImage(data: data!) {
                          
                            DispatchQueue.main.async {
                                retrievedImage = image
                                profileImage = retrievedImage
                            }
                        }
                    }
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
}




//MARK: PreView
//struct EditCardInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCardInfoView(retrievedImage: $retrievedImage)
//    }
//}



//MARK: ProfilePictureView
struct ProfilePictureView: View {
    
    @EnvironmentObject var card: CardDetailData
    @EnvironmentObject var user : userData
    
    @State private var isShowingImagePicker = false
    @State private var profileImage: UIImage?
    
    @Binding var selectedImage: UIImage?
    @Binding var retrievedImage: UIImage
    
    var body: some View {
        VStack {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 154, height: 154)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 0.3)
            } else {
                /// card.memoji != " ": 프로필 이미지가 아예 없을 시나리오 대응
                if card.memoji != "" {
                    Image(uiImage: retrievedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 154, height: 154)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(radius: 0.3)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 154, height: 154)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                }
            }
            
            
            
            Button(action: {
                self.isShowingImagePicker = true
            }) {
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .frame(width: 29,height: 29)
                    .foregroundColor(hexStringToColor(hexString: "FF722D"))
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

//MARK: MainprofileView
struct DetailEditProfileView: View {
    @State var discriptionText: String = ""
    @EnvironmentObject var card: CardDetailData
    
    @Binding var selectedImage: UIImage?
    @Binding var retrievedImage: UIImage
    
    var body: some View {
        VStack {
            ProfilePictureView(selectedImage: $selectedImage, retrievedImage: $retrievedImage)
                .padding()
            
            letterLimitTextField(placeholder: "안녕하세요! 겉바속촉 디발자 리앤입니다!", commentText: $discriptionText, letterLimit: 50)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .padding()
                .onAppear() {
                    discriptionText = card.introduce
                }
                .onChange(of: discriptionText, perform: { newValue in
                    card.introduce = discriptionText
                })
        }
    }
}

//MARK: SkillView
struct DetailEditSkillView: View {
    @State var mySkillText: String = ""
    @State var myFutureSkillText: String = ""
    @EnvironmentObject var card: CardDetailData
    
    @State var isMySkillEditShow: Bool = false
    @State var isWishSkillEditShow: Bool = false
    
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
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack{
                    ForEach(card.skills, id: \.self){ item in
                        skillIconView(text: item)
                            .frame(minHeight: 35)
                            .padding(.leading)
                    }
                }
            }
            
            HStack {
                Spacer()
                Button {
                    // MARK: 현재 스킬셋 화면 연결하기
                    handleMySkillBtnTapped()
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
            letterLimitTextField(placeholder: "내가 가지고 있는 스킬셋에 대해 자세하게 서술해주세요!", commentText: $mySkillText, letterLimit: 100)
                .frame(maxWidth: .infinity,minHeight: 160)
                .padding()
                .onAppear() {
                    mySkillText = card.introduceSkill
                }
                .onChange(of: mySkillText, perform: { newValue in
                    card.introduceSkill = mySkillText
                })
        }
        
        VStack {
            Text("키우고 싶은 스킬셋")
                .bold()
                .font(.system(size: 18))
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(card.wishSkills, id: \.self){ item in
                        skillIconView(text: item)
                            .frame(minHeight: 35)
                            .padding(.leading)
                    }
                }
            }
            
            HStack {
                Spacer()
                Button {
                    // MARK: 목표 스킬셋 화면 연결하기
                    handleFutureSkillBtnTapped()
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
            .sheet(isPresented: $isWishSkillEditShow) {
                EditSkillView(isShow: $isWishSkillEditShow, card: card, isMySkill: false)
            }
            .sheet(isPresented: $isMySkillEditShow) {
                EditSkillView(isShow: $isMySkillEditShow, card: card, isMySkill: true)
            }
            
            Text("추가 설명")
                .frame(maxWidth: .infinity,alignment: .leading)
                .bold()
                .font(.system(size: 13))
                .padding(.bottom,-15)
                .padding(.leading)
            
            letterLimitTextField(placeholder: "내가 키우고 싶은 스킬셋에 대해 자세하게 서술해주세요!", commentText: $myFutureSkillText, letterLimit: 100)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 160)
                .onAppear() {
                    myFutureSkillText = card.wishSkillIntroduce
                }
                .onChange(of: myFutureSkillText, perform: { newValue in
                    card.wishSkillIntroduce = myFutureSkillText
                })
        }
        
        
    }
    
    func handleMySkillBtnTapped() {
        isMySkillEditShow = true
    }
    
    func handleFutureSkillBtnTapped() {
        isWishSkillEditShow = true
    }
    
    func removeElements(withValue value: String, from array: [String]) -> [String] {
        return array.filter { $0 != value }
    }
    
    
    func skillIconView(text: String) -> some View {
        HStack {
            Text(text)
                .font(.system(size: 15))
                .padding(.leading,20)
//                .frame(minWidth: 107,minHeight: 30,alignment: .leading)
            
            Button  {
                //                arr = removeElements(withValue: text, from: arr)
            } label: {
                Image(systemName: "x.circle.fill")
                    .foregroundColor(hexStringToColor(hexString: "#979797"))
            }
//            .padding(.trailing,40)
            .frame(minWidth: 14,minHeight: 14)
        }
        .frame(minWidth: 107,minHeight: 30)
        .background {
            RoundedRectangle(cornerRadius: 35)
                .foregroundColor(.white)
                .shadow(radius: 3)
        }
        
    }
}

//MARK: myGoal
struct DetailEditMyGoal: View {
    @EnvironmentObject var card: CardDetailData
    
    @State var isSheet: Bool = false
    @State var myGoal: String = ""
    var body: some View {
        // myGoal -
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
                    .frame(minWidth: 100)
                    .foregroundColor(hexStringToColor(hexString: "#979797"))
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundColor(hexStringToColor(hexString: "#979797"))
            })
            
            
        }
        .sheet(isPresented: $isSheet) {
            RoleGoalInputSheetView(sendInputText: $myGoal)
        }
        .onAppear() {
            myGoal = card.growthTarget
        }
        
    }
    
    func handlePmSet() {
        self.myGoal = "PM"
        card.growthTarget = "PM"
    }
    func handleIosSet() {
        self.myGoal = "iOS 개발자"
        card.growthTarget = "iOS 개발자"
    }
    func handleServerSet() {
        self.myGoal = "서버 개발자"
        card.growthTarget = "서버 개발자"
    }
    func handleUiandUxSet() {
        self.myGoal = "UI/UX 디자이너"
        card.growthTarget = "UI/UX 디자이너"
    }
    func handleOtherSet() {
        self.isSheet = true
    }
}

//MARK: CollaborationView

struct DetailEditCollaborationView: View {
    @State var discriptionText: String = ""
    @State var collaborationTypes: String = "Driver"
    @State var isCollaborationSheet: Bool = false
    @EnvironmentObject var card: CardDetailData
    
    let collaboraionDatas: [CollaborationButtonData] = [
        CollaborationButtonData(buttonColor: collaborationKeywordColor_0, buttonTitle: "갈등중재"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_1, buttonTitle: "리더십"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_2, buttonTitle: "팔로워십"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_3, buttonTitle: "소통왕"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_4, buttonTitle: "감성지능"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_5, buttonTitle: "비판적 사고"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_6, buttonTitle: "공감능력"),
        CollaborationButtonData(buttonColor: collaborationKeywordColor_7, buttonTitle: "유연한 사고"),
    ]
    @State var collaboraionIndexArr: [Int] = [0,1,2]
    
    enum CollaborationTypes: Int {
        case Analytical = 0
        case Driver
        case Amiable
        case Expressive
    }
    
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
                    .padding()
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
                        .frame(minWidth: 85)
                        .foregroundColor(hexStringToColor(hexString: "#979797"))
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(hexStringToColor(hexString: "#979797"))
                })
                .onAppear() {
                    switch card.communicationType {
                    case 0:
                        collaborationTypes = "Analytical"
                    case 1:
                        collaborationTypes = "Driver"
                    case 2:
                        collaborationTypes = "Amiable"
                    case 3:
                        collaborationTypes = "Expressive"
                    default:
                        collaborationTypes = "Analytical"
                    }
                }
                
                Spacer()
                
                
            }
            
            HStack {
                Text("나의 협업 키워드")
                    .padding(.trailing)
                    .bold()
                    .font(.system(size: 18))
                    .frame(minWidth: 150,alignment: .leading)
                    .padding()
                
                Text("(3개 선택)")
                    .foregroundColor(hexStringToColor(hexString: "#979797"))
                    .padding()
                    .padding(.leading,-50)
                Spacer()
                Button {
                    handleCollaborationBtnTapped()
                } label: {
                    VStack(){
                        Text("\(collaboraionDatas[collaboraionIndexArr[0]].buttonTitle)")
                            .font(.system(size: 15))
                            .foregroundColor(hexStringToColor(hexString: "#979797"))
                        Text("\(collaboraionDatas[collaboraionIndexArr[1]].buttonTitle )")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                        Text("\(collaboraionDatas[collaboraionIndexArr[2]].buttonTitle)")
                            .foregroundColor(hexStringToColor(hexString: "#979797"))
                            .font(.system(size: 15))
                    }
                    .frame(minWidth: 80)
                    Image(systemName: "chevron.forward")
                        .padding(.top,-27)
                        .foregroundColor(hexStringToColor(hexString: "#979797"))
                }
                .padding()
                .sheet(isPresented: $isCollaborationSheet) {
                    //MARK: 협업 선택 창 넣기
                    EditCollaboraionView(goNext: $isCollaborationSheet)
                        .onDisappear() {
                            collaboraionIndexArr = indicesOfTrueValues(in: card.cooperationKeywords)
                        }
                }

                
            }
            
        }
        .onAppear() {
            collaboraionIndexArr = indicesOfTrueValues(in: card.cooperationKeywords)
        }
    }
    
    func handleCollaborationBtnTapped() {
        isCollaborationSheet = true
    }
    
    func handleDriverSet() {
        self.collaborationTypes = "Driver"
        card.communicationType = CollaborationTypes.Driver.rawValue
    }
    func handleAnalyticalSet() {
        self.collaborationTypes = "Analytical"
        card.communicationType = CollaborationTypes.Analytical.rawValue
    }
    func handleAmiableSet() {
        self.collaborationTypes = "Amiable"
        card.communicationType = CollaborationTypes.Amiable.rawValue
    }
    func handleExpressiveSet() {
        self.collaborationTypes = "Expressive"
        card.communicationType = CollaborationTypes.Expressive.rawValue
    }
    
    func indicesOfTrueValues(in array: [Bool]) -> [Int] {
        return array.enumerated().compactMap { index, value in
            value ? index : nil
        }
    }
    
}




// MARK: - Storage: retrievePhotos() (Method)
/// Storage에서 이미지 가져오기
func retrievePhotos(retrievedImage: UIImage?) {
    @EnvironmentObject var card: CardDetailData
    @EnvironmentObject var user: userData
    @State var retrievedImage = UIImage()
    
    // Get the data from the database
    let docRef = Firestore.firestore().collection("CardDetails").document(user.id)
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let imagePath = document.get("memoji")
            print(imagePath ?? "")
            
            // Get a reference to storage
            let storageRef = Storage.storage().reference()
            
            // Specify the path
            let fileRef = storageRef.child(imagePath as! String)
            
            // Retrieve the data
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                
                // Check for errors
                if error == nil && data != nil {
                   
                    // Create a UIImage and put it into display
                    if let image = UIImage(data: data!) {
                      
                        DispatchQueue.main.async {
                            retrievedImage = image
                        }
                    }
                }
            }
            
        } else {
            print("Document does not exist")
        }
    }
}

