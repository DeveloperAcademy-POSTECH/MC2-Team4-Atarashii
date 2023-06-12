//
//  UtilFunction.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/12.
//


import SwiftUI
import Firebase
import FirebaseAuth

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
    
    
    static func removeAccount() {
      let token = UserDefaults.standard.string(forKey: "refreshToken")
        
    print(token)

      if let token = token {
          let url = URL(string: "https://us-central1-atarashii2-fa9ec.cloudfunctions.net/revokeToken?refresh_token=\(token)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "https://apple.com")!
          
          let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard data != nil else { return }
          }
          task.resume()
      }
      //Delete other information from the database...
        
        // Delete All UserDefaults
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        // Sign out on FirebaseAuth
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        print("Sign out Success")
    }
}


