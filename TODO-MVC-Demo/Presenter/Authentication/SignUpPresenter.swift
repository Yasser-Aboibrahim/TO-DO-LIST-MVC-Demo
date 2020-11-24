//
//  SignUpPresenter.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/13/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

class SignUpPresenter{
    
    private weak var view: SignUpVC!
    
    init(view: SignUpVC){
        self.view = view
    }
    
//    private func userDataValidator( name: String, userEmail: String, Password: String, age: String)-> Bool{
//        guard ValidatorManager.isValidEmail(email: userEmail) else{
//            return false
//        }
//        guard ValidatorManager.isValidPassword(password: Password) else{
//            return false
//        }
//        guard ValidatorManager.isValidName(name: name) else{
//            return false
//        }
//        guard ValidatorManager.isValidAge(age: age) else{
//            return false
//        }
//
//        return true
//    }
    
    private func isDataEntered( name: String, userEmail: String, Password: String, age: String)-> Bool{
        guard ValidationManager.shared().isEmptyEmail(email: userEmail) else{
            view.showAlert(alertTitle: "Incompleted Data Entry",message: "Please Enter Email",actionTitle: "Dismiss")
            return false
        }
        guard ValidationManager.shared().isEmptyPassword(password: Password) else{
            view.showAlert(alertTitle: "Incompleted Data Entry",message: "Please Enter Password",actionTitle: "Dismiss")
            return false
        }
        guard ValidationManager.shared().isEmptyName(name: name) else{
            view.showAlert(alertTitle: "Incompleted Data Entry",message: "Please Enter Name",actionTitle: "Dismiss")
            return false
        }
        guard ValidationManager.shared().isEmptyAge(age: age) else{
            view.showAlert(alertTitle: "Incompleted Data Entry",message: "Please Enter Age",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
    private func isValidRegex(userEmail: String, Password: String)-> Bool{
        guard ValidationManager.shared().isValidEmail(email: userEmail) else{
            view.showAlert(alertTitle: "Wrong Email Form",message: "Please Enter Valid email(a@a.com)",actionTitle: "Dismiss")
            return false
        }
        guard ValidationManager.shared().isValidPassword(password: Password) else{
            view.showAlert(alertTitle: "Wrong Password Form",message: "Password need to be : \n at least one uppercase \n at least one digit \n at leat one lowercase \n characters total",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
    private func signUpWithEnteredData(name: String, userEmail: String, password: String, age: String){
        view.showLoader()
        let body = UserRegister(name: name, email: userEmail, password: password, age: Int(age)!)
        APIManager.registerAPIRouter(body: body){ response in
            switch response{
            case .failure(let error):
                if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                    self.view.showAlert(alertTitle: "Error",message: "Incorrect Email and Password",actionTitle: "Dismiss")
                }else{
                    self.view.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
                    print(error.localizedDescription)
                }
            case .success(let result):
                print(result)
                print("Sign Up Completed")
            }
            
            self.view.goToSignInVC()
            self.view.hideLoader()
        }
    }
    
    func signUpUser(name: String, email: String, password: String, age: String){
        if isDataEntered(name: name, userEmail: email, Password: password, age: age)
        {
            if isValidRegex(userEmail: email, Password: password){
                signUpWithEnteredData(name: name, userEmail: email, password: password, age: age)
            }
        }
    }
    
    
}
