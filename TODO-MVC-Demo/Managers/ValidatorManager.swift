//
//  ValidatorManager.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/20/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation

class ValidatorManager{
    class func isValidEmail(email: String?)-> Bool{
        guard let email = email?.trimmed, !email.isEmpty else{
            ShowAlertsManager.showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter email",actionTitle: "Dismiss")
            return false
        }
        guard RegexValidationManager.isValidEmail(email: email) else{
            ShowAlertsManager.showAlertWithCancel(alertTitle: "Wrong Email Form",message: "Please Enter Valid email(a@a.com)",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
    class func isValidPassword(password: String?)-> Bool{
        guard let password = password, !password.isEmpty else{
            ShowAlertsManager.showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter Password",actionTitle: "Dismiss")
            return false
        }
        guard RegexValidationManager.isValidPassword(password: password) else{
            ShowAlertsManager.showAlertWithCancel(alertTitle: "Wrong Password Form",message: "Password need to be : \n at least one uppercase \n at least one digit \n at leat one lowercase \n characters total",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
    class func isValidAge(age: String?)-> Bool{
        guard let age = age, !age.isEmpty else{
            ShowAlertsManager.showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter Age",actionTitle: "Dismiss")
            return false
        }
        
        return true
    }
    
    class func isValidName(name: String?)-> Bool{
        guard let name = name, !name.isEmpty else{
            ShowAlertsManager.showAlertWithCancel(alertTitle: "Incompleted Data Entry",message: "Please Enter Name",actionTitle: "Dismiss")
            return false
        }
        
        return true
    }
}
