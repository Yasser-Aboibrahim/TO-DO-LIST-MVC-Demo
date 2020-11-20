//
//  SignInPresenter.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/11/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

class SignInPresenter{
    private weak var view: SignInVC!
    
    init(view: SignInVC){
        self.view = view
    }
    
    private func userDataValidator(userEmail: String, Password: String)-> Bool{
        guard ValidatorManager.isValidEmail(email: userEmail) else{
            return false
        }
        guard ValidatorManager.isValidPassword(password: Password) else{
            return false
        }
        return true
    }
    
     private func signInWithEnteredData(email: String, password: String){
  
        view.showLoader()
        APIManager.loginAPIRouter(email: email, password: password){ response in
            switch response{
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                    self.view.showAlert(alertTitle: "Error",message: "Incorrect Email and Password",actionTitle: "Dismiss")
                }else{
                    self.view.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
                    print(error.localizedDescription)
                }
            case .success(let result):
                print(result.token)
                UserDefaultsManager.shared().token = result.token
                UserDefaultsManager.shared().userId = result.user.id
                self.view.goToTodoListVC()
            }
            self.view.hideLoader()
        }
    }
    
    func logInUser(email: String, password: String){
        if userDataValidator(userEmail: email, Password: password){
                signInWithEnteredData(email: email, password: password)
        }
    }
    
    
}
