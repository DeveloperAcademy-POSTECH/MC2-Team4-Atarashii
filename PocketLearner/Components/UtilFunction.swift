//
//  UtilFunction.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/12.
//


import SwiftUI
import Firebase

protocol Functions : AnyObject {
    
}


class UtilFunction: Functions {
    
    static func noKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}
