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
    
    static func popToRootView() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            findNavigationController(viewController: UIApplication.shared.windows.filter { $0.isKeyWindow
            }.first?.rootViewController)?
                .popToRootViewController(animated: true)
        }
    }
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        if let navigationController = viewController as? UINavigationController
        {
            return navigationController
        }
        for childViewController in viewController.children {
            return findNavigationController(viewController:
                                                childViewController)
        }
        return nil
    }
    
    
    func removeAccount() {
      let token = UserDefaults.standard.string(forKey: "refreshToken")

      if let token = token {
          let url = URL(string: "https://YOUR-URL.cloudfunctions.net/revokeToken?refresh_token=\(token)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "https://apple.com")!
          
          let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard data != nil else { return }
          }
          task.resume()
      }
      //Delete other information from the database...
      FirebaseAuthentication.shared.signOut()
    }
}


