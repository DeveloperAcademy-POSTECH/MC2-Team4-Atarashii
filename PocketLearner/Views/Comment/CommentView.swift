//
//  CommentView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/09.
//

import SwiftUI

struct CommentData {
    let cardUserID: String
    let commenterID: String
    let lastUpdateDate: Date
    let createDate: Date
    let commentText: String
    let commenterNickKorean: String
    let commenterNickEnglish: String
}

struct CommentView: View {
    @EnvironmentObject var user: userData
    
    // TODO : check from db. (Was I commented)
    @State var isCommented: Bool = false
    @State var showingAlert: Bool = false
    @State var goEdit: Bool = false
    @State var goCreate: Bool = false
    
    let isMine: Bool
    let learnerInfo: UserInfo
    
    let text: String = """
    칭찬글 블라블라 어쩌구 칭찬글 블라블라라라
    라라라 어쩌구 칭찬글 블라블라 어쩌구
    칭찬글 블라블라 어쩌구 칭찬글 블라블라
    어쩌구 칭찬글 블라블라 어쩌구
    """
    let text2: String = "123"
    
    @State var commentList: [CommentData] = []
    @State var myComment: CommentData = CommentData(cardUserID: "", commenterID: "", lastUpdateDate: Date(), createDate: Date(), commentText: "", commenterNickKorean: "", commenterNickEnglish: "")
    
    var body: some View {
        VStack{
            HStack{
                Text("\(isMine ? user.nickKorean : learnerInfo.nickKorean), ")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(mainAccentColor)
                + Text("칭찬해요!")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(.black)
            }.padding(.bottom, 30).padding(.top, 20)
                
            if isCommented {
                HStack{
                    Text("내가 남긴 칭찬")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(commentTextBlackColor))
                    Spacer()
                }
                CommentBox(commentData: myComment)
                HStack{
                    Spacer()
                    
                    Button(action: {
                        goEdit = true
                    }) {
                        Text("수정하기")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(commentTextBlackColor))
                    }
                    .navigationDestination(isPresented: $goEdit){
                        CommentCreateView(learnerInfo: learnerInfo)
                    }
                    
                    Spacer()
                    Divider().frame(width: 1, height: 30)
                        .foregroundColor(Color(dividerGrayColor))
                    Spacer()
                    Button(action: {
                        // TODO : to 삭제 view
                        self.showingAlert = true
                    }){
                        Text("삭제하기")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                    }.alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("칭찬을 삭제할까요?"),
                            message: Text("\n정말로 내가 남긴\n칭찬 메시지를 삭제할까요?"),
                            primaryButton: .destructive(Text("Delete")) {
                                // delete action
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    Spacer()
                }.padding(.top, 10)
                Divider()
                    .frame(height: 1)
                    .foregroundColor(Color(dividerGrayColor))
                    .padding(.vertical, 10)
            }
            ScrollView(showsIndicators: false){
                ForEach(commentList.indices, id: \.self) { index in
                    if commentList[index].commenterID != user.id{
                        CommentBox(commentData: commentList[index])
                    }
                }
            }
            Spacer()
            if !isCommented && !isMine{
                Button(action: {
                    goCreate = true
                }){
                    Text("나도 \(learnerInfo.nickKorean) 칭찬하기")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 19)
                        .padding(.horizontal, 75)
                        .frame(width: 314, height: 51)
                        .background(
                            RoundedRectangle(cornerRadius: 13)
                                .fill(mainAccentColor)
                        )
                        .padding(.top, 10)
                }.navigationDestination(isPresented: $goCreate){
                    CommentCreateView(learnerInfo: learnerInfo)
                }
            }
        }.padding(.horizontal, 39)
        .task {
            // TODO: Data fetch from DB
            loadComments()
        }
    }
    
    func loadComments(){
        let commentColRef = db.collection("Comments")
        
        commentColRef.whereField("cardUserID", isEqualTo: isMine ? user.id : learnerInfo.id).getDocuments { snapshot, error in
            if let error = error {
                print("comment fetching error: \(error) - commentView")
                return
            }
            
            for document in snapshot!.documents {
                let data = document.data()
                
                let cardUserID = data["cardUserID"] as? String ?? ""
                let commenterID = data["commenterID"] as? String ?? ""
                let lastUpdateDate = data["lastUpdateDate"] as? Date ?? Date()
                let createDate = data["createDate"] as? Date ?? Date()
                let commentText = data["commentText"] as? String ?? ""
                let commenterNickKorean = data["commenterNickKorean"] as? String ?? ""
                let commenterNickEnglish = data["commenterNickEnglish"] as? String ?? ""
                
                let comment = CommentData(cardUserID: cardUserID, commenterID: commenterID, lastUpdateDate: lastUpdateDate, createDate: createDate, commentText: commentText, commenterNickKorean: commenterNickKorean, commenterNickEnglish: commenterNickEnglish)
                
                commentList.append(comment)
                
                if commenterID == user.id {
                    isCommented = true
                    myComment = comment
                }
            }
            print("commentList: \(commentList)")
        }
    }
}

struct CommentBox: View {
    @EnvironmentObject var user: userData
    let commentData: CommentData
    @State var isMine: Bool = false
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text(commentData.commentText)
                    .font(.system(size: 14, weight: .regular))
                    .lineSpacing(6)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(isMine ? .white : Color(commentTextBlackColor))
                Spacer()
            }
            if !isMine{
                Spacer().frame(height: 21)
                HStack{
                    Spacer()
                    Text("From. \(commentData.commenterNickEnglish)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(commentTextBlackColor))
                }
            }
        }
        .padding(20)
        .frame(width: 314)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(isMine ? .black : Color(commentBoxGrayColor))
        ).task {
            isMine = (commentData.commenterID == user.id)
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView().previewDevice("iPhone 14")
//    }
//}
