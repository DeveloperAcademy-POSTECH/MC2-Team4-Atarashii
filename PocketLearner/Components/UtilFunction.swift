//
//  UtilFunction.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/11.
//

import SwiftUI
import Firebase

protocol Functions : AnyObject {
    
}


class UtilFunction: Functions {
    
    static func noKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
    
//
//    static func setPostID(id: String) {
//        UserDefaults.standard.set(id, forKey: "id")
//        NotificationCenter.default.post(name: NSNotification.Name("id"),object: nil)
//    }
//    static func setPostStatus(status: Int) {
//        UserDefaults.standard.set(status, forKey: "status")
//        NotificationCenter.default.post(name: NSNotification.Name("status"),object: nil)
//    }
//    static func setPostNick(nick: String) {
//        UserDefaults.standard.set(nick, forKey: "nick")
//        NotificationCenter.default.post(name: NSNotification.Name("nick"),object: nil)
//    }
//    static func setPostCereal(cereal: Int) {
//        UserDefaults.standard.set(cereal, forKey: "cereal")
//        NotificationCenter.default.post(name: NSNotification.Name("cereal"),object: nil)
//    }
//    static func setPostLogin(login: Bool) {
//        UserDefaults.standard.set(login, forKey: "login")
//        NotificationCenter.default.post(name: NSNotification.Name("login"),object: nil)
//    }
//
//    static func setPostVisitID(visitID: String) {
//        UserDefaults.standard.set(visitID, forKey: "visitid")
//        NotificationCenter.default.post(name: NSNotification.Name("visitid"),object: nil)
//    }
//
//    static func setPostMyColor(mycolor: Int) {
//        UserDefaults.standard.set(mycolor, forKey: "mycolor")
//        NotificationCenter.default.post(name: NSNotification.Name("mycolor"),object: nil)
//    }
//    static func setPostLoading(loading: Bool) {
//        UserDefaults.standard.set(loading, forKey: "loading")
//        NotificationCenter.default.post(name: NSNotification.Name("loading"),object: nil)
//    }
//    static func setPostMessageRoomCode(messageRoomCode: String) {
//        UserDefaults.standard.set(messageRoomCode, forKey: "messageRoomCode")
//        NotificationCenter.default.post(name: NSNotification.Name("messageRoomCode"),object: nil)
//    }
//    static func setPostChatRoomCode(chatRoomCode: String) {
//        UserDefaults.standard.set(chatRoomCode, forKey: "chatRoomCode")
//        NotificationCenter.default.post(name: NSNotification.Name("chatRoomCode"),object: nil)
//    }
//
//    static func setPostWaitChat(waitchat: Bool) {
//        UserDefaults.standard.set(waitchat, forKey: "waitchat")
//        NotificationCenter.default.post(name: NSNotification.Name("waitchat"),object: nil)
//    }
//
//    static func setPostChatting(chatting: Bool) {
//        UserDefaults.standard.set(chatting, forKey: "chatting")
//        NotificationCenter.default.post(name: NSNotification.Name("chatting"),object: nil)
//    }
//    static func setPostPopcorn(popcorn: Bool) {
//        UserDefaults.standard.set(popcorn, forKey: "popcorn")
//        NotificationCenter.default.post(name: NSNotification.Name("popcorn"),object: nil)
//    }
//    static func setPostToken(token: String) {
//        UserDefaults.standard.set(token, forKey: "token")
//        NotificationCenter.default.post(name: NSNotification.Name("token"),object: nil)
//    }
//    static func setPostNowChattingWith(nowChattingWith: String) {
//        UserDefaults.standard.set(nowChattingWith, forKey: "nowChattingWith")
//        NotificationCenter.default.post(name: NSNotification.Name("nowChattingWith"),object: nil)
//    }
//    static func setPostTuto1(tuto1: Bool) {
//        UserDefaults.standard.set(tuto1, forKey: "tuto1")
//        NotificationCenter.default.post(name: NSNotification.Name("tuto1"),object: nil)
//    }
//    static func setPostTuto2(tuto2: Bool) {
//        UserDefaults.standard.set(tuto2, forKey: "tuto2")
//        NotificationCenter.default.post(name: NSNotification.Name("tuto2"),object: nil)
//    }
//    static func setPostTuto3(tuto3: Bool) {
//        UserDefaults.standard.set(tuto3, forKey: "tuto3")
//        NotificationCenter.default.post(name: NSNotification.Name("tuto3"),object: nil)
//    }
//    static func setPostNiceAuthed(niceAuthed: Int) {
//        UserDefaults.standard.set(niceAuthed, forKey: "niceAuthed")
//        NotificationCenter.default.post(name: NSNotification.Name("niceAuthed"),object: nil)
//    }
//    static func setPostChatWindow(chatWindow: Bool) {
//        UserDefaults.standard.set(chatWindow, forKey: "chatWindow")
//        NotificationCenter.default.post(name: NSNotification.Name("chatWindow"),object: nil)
//    }
//    static func setPostTabIndex(tabIndex: Int) {
//        UserDefaults.standard.set(tabIndex, forKey: "tabIndex")
//        NotificationCenter.default.post(name: NSNotification.Name("tabIndex"),object: nil)
//    }
//    static func setPostOffsetX(offsetX: CGFloat) {
//        UserDefaults.standard.set(offsetX, forKey: "offsetX")
//        NotificationCenter.default.post(name: NSNotification.Name("offsetX"),object: nil)
//    }
//    static func setPostShowNewFriends(showNewFriends: Bool) {
//        UserDefaults.standard.set(showNewFriends, forKey: "showNewFriends")
//        NotificationCenter.default.post(name: NSNotification.Name("showNewFriends"),object: nil)
//    }
//    static func setPostShowMsgRoom(showMsgRoom: Bool) {
//        UserDefaults.standard.set(showMsgRoom, forKey: "showMsgRoom")
//        NotificationCenter.default.post(name: NSNotification.Name("showMsgRoom"),object: nil)
//    }
//    static func setPostFriendCode(friendCode: String) {
//        UserDefaults.standard.set(friendCode, forKey: "friendCode")
//        NotificationCenter.default.post(name: NSNotification.Name("friendCode"),object: nil)
//    }
//    static func setPostSns(sns: Bool) {
//        UserDefaults.standard.set(sns, forKey: "sns")
//        NotificationCenter.default.post(name: NSNotification.Name("sns"),object: nil)
//    }
//
//
//    static func getPostedID() -> String {
//        return UserDefaults.standard.value(forKey: "id") as? String ?? ""
//    }
//    static func getPostedStatus() -> Int {
//        return UserDefaults.standard.value(forKey: "status") as? Int ?? 0
//    }
//    static func getPostedNick() -> String {
//        return UserDefaults.standard.value(forKey: "nick") as? String ?? ""
//    }
//    static func getPostedCereal() -> Int {
//        return UserDefaults.standard.value(forKey: "cereal") as? Int ?? 0
//    }
//    static func getPostedLogin() -> Bool {
//        return UserDefaults.standard.value(forKey: "login") as? Bool ?? false
//    }
//    static func getPostedVisitID() -> String {
//        return UserDefaults.standard.value(forKey: "visitid") as? String ?? ""
//    }
//    static func getPostedMyColor() -> Int {
//        return UserDefaults.standard.value(forKey: "mycolor") as? Int ?? 0
//    }
//    static func getPostedLoading() -> Bool {
//        return UserDefaults.standard.value(forKey: "loading") as? Bool ?? false
//    }
//    static func getPostedMessageRoomCode() -> String {
//        return UserDefaults.standard.value(forKey: "messageRoomCode") as? String ?? ""
//    }
//    static func getPostedChatRoomCode() -> String {
//        return UserDefaults.standard.value(forKey: "chatRoomCode") as? String ?? ""
//    }
//    static func getPostedWaitChat() -> Bool {
//        return UserDefaults.standard.value(forKey: "waitchat") as? Bool ?? false
//    }
//    static func getPostedChatting() -> Bool {
//        return UserDefaults.standard.value(forKey: "chatting") as? Bool ?? false
//    }
//    static func getPostedPopcorn() -> Bool {
//        return UserDefaults.standard.value(forKey: "popcorn") as? Bool ?? false
//    }
//    static func getPostedToken() -> String {
//        return UserDefaults.standard.value(forKey: "token") as? String ?? ""
//    }
//    static func getPostedNowChattingWith() -> String {
//        return UserDefaults.standard.value(forKey: "nowChattingWith") as? String ?? ""
//    }
//    static func getPostedTuto1() -> Bool {
//        return UserDefaults.standard.value(forKey: "tuto1") as? Bool ?? false
//    }
//    static func getPostedTuto2() -> Bool {
//        return UserDefaults.standard.value(forKey: "tuto2") as? Bool ?? false
//    }
//    static func getPostedTuto3() -> Bool {
//        return UserDefaults.standard.value(forKey: "tuto3") as? Bool ?? false
//    }
//    static func getPostedNiceAuthed() -> Int {
//        return UserDefaults.standard.value(forKey: "niceAuthed") as? Int ?? 0 // 0: 미인증  1: 인증  2: 18세미만인증
//    }
//    static func getPostedChatWindow() -> Bool {
//        return UserDefaults.standard.value(forKey: "chatWindow") as? Bool ?? false
//    }
//    static func getPostedTabIndex() -> Int {
//        return UserDefaults.standard.value(forKey: "tabIndex") as? Int ?? 0
//    }
//    static func getPostedOffsetX() -> CGFloat {
//        return UserDefaults.standard.value(forKey: "offsetX") as? CGFloat ?? CGFloat(0)
//    }
//    static func getPostedShowNewFriends() -> Bool {
//        return UserDefaults.standard.value(forKey: "showNewFriends") as? Bool ?? false
//    }
//    static func getPostedShowMsgRoom() -> Bool {
//        return UserDefaults.standard.value(forKey: "showMsgRoom") as? Bool ?? false
//    }
//    static func getPostedFriendCode() -> String {
//        return UserDefaults.standard.value(forKey: "friendCode") as? String ?? ""
//    }
//    static func getPostedSns() -> Bool {
//        return UserDefaults.standard.value(forKey: "sns") as? Bool ?? false
//    }
//
//
}
