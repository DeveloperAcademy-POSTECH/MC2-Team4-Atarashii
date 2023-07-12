//
//  CommentCreateView.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/09.
//

import SwiftUI

struct CommentCreateView: View {
    @EnvironmentObject var user: userData
    @Environment(\.presentationMode) var presentationMode
    
    let placeholder: String = "이 러너와의 협업 경험을 통해 알게 된 장점을 칭찬해주세요 :)"

    @State var commentText: String = ""
    
    let learnerInfo: UserInfo
    let isEdit: Bool
    let myComment: CommentData // isEdit == true일 때만 사용, false이면 dummy data 넘어옴.

    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("To. ")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(mainAccentColor)
                + Text("\(learnerInfo.nickKorean)")
                    .font(.system(size: 34, weight: .bold))
                Spacer()
            }
            letterLimitTextField(placeholder: "이 러너와의 협업 경험을 통해 알게 된\n장점을 칭찬해주세요 :)", commentText: $commentText, letterLimit: 100)
            
            Button(action: {
                // TODO : 작성 완료, 수정 시나리오
                if isEdit {
                    editComment()
                } else {
                    createComment()
                }
            }){
                Text(isEdit ? "수정 완료" : "작성 완료하기")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 19)
                    .padding(.horizontal, 105)
                    .frame(width: 314)
                    .background(
                        RoundedRectangle(cornerRadius: 13)
                            .fill( (commentText == myComment.commentText) ? Color(buttonDisabledGrayColor) : mainAccentColor )
                    )
            }.padding(.top, 20).disabled(commentText == myComment.commentText)
        }.padding(.horizontal, 39).navigationTitle("칭찬 리뷰 수정").task {
            if isEdit {
                commentText = myComment.commentText
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text("확인")){
                presentationMode.wrappedValue.dismiss()
            })
        }d
    }
    
    func editComment() {
        let commentDocRef = db.collection("Comments").document("\(learnerInfo.id)_\(user.id)")
        
        commentDocRef.updateData([
            "lastUpdateDate": Date(),
            "commentText": commentText,
        ]) { err in
            if let err = err {
                print("리뷰 수정 오류: \(err)")
                alertMessage = "리뷰 수정 오류.\n인터넷 연결을 확인하고 다시 시도해 주세요."
            } else {
                print("리뷰가 성공적으로 수정되었습니다!")
                alertMessage = "리뷰가 성공적으로 수정되었습니다!"
            }
            showAlert = true
        }
    }
    
    func createComment() {
        let commentDocRef = db.collection("Comments").document("\(learnerInfo.id)_\(user.id)")
        
        commentDocRef.setData([
            "cardUserID": learnerInfo.id,
            "commenterID": user.id,
            "lastUpdateDate": Date(),
            "createDate": Date(),
            "commentText": commentText,
            "commenterNickEnglish": user.nickEnglish,
            "commenterNickKorean": user.nickKorean
        ]) { err in
            if let err = err {
                print("리뷰 작성 오류: \(err)")
                alertMessage = "리뷰 작성 오류.\n인터넷 연결을 확인하고 다시 시도해 주세요."
            } else {
                print("리뷰가 성공적으로 작성되었습니다!")
                alertMessage = "리뷰가 성공적으로 작성되었습니다!"
            }
            showAlert = true
        }
    }
}

