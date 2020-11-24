//
//  ProfilePresnter.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 11/13/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import Foundation
import UIKit

class ProfilePresenter{
    
    private var userData: UserData?
    private weak var view: ProfileVC!
    
    init(view: ProfileVC){
        self.view = view
    }
    
    
     func getUserData(){
        view.showLoader()
        
        APIManager.getUserDataAPIRouter{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.userData = result
                
                print(result)
                self.setUserData()
            }
            DispatchQueue.main.async {
                self.getUserImage()
                self.userNameInitials()
                self.view.hideLoader()
            }
            
        }
    }
    
     func getUserImage(){
        view.showLoader()

        APIManager.getingUserImageAPIRouter { (image, error) in
            guard  error == nil else{
                print(error!.localizedDescription)
                return
            }
            guard  image != nil else{
                print("No Image")
                return
            }
            self.view.setUserImage(image: image!)
            self.view.hideLoader()
        }
    }
    
    private func setUserData(){
            view.setUserData(userData: userData!)
    }
    
    private func userNameInitials(){
        if let stringInput = userData?.name {
            let initials = stringInput.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
            view.userNameWithNoImage(nameInitials: initials)
        }else{
            view.userNameWithNoImage(nameInitials: "")
        }
    }
    
     func logOut(){
        view.showLoader()
        APIManager.logOutUserAPIRouter{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                print(result)
                print("Log Out Completed")
            }
            DispatchQueue.main.async {
                self.view.hideLoader()
                UserDefaultsManager.shared().token?.removeAll()
                self.view.successfullyLoggedOut()
            }
        }
    }
    
     func uploadUserImage(image: UIImage){
        view.showLoader()
        APIManager.uploadUserImage(userImage: image){ error in
            if error != nil {
                self.view.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
            } else {
                print("Uploading photo is Completed")
            }
            DispatchQueue.main.async {
                self.getUserImage()
                self.view.hideLoader()
            }
            
        }
    }
    func updateUserData(age: Int){
            view.showLoader()
            APIManager.updateUserDataAPIRouter(age: age){ response in
                switch response{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let result):
                    print(result)
                    
                }
                DispatchQueue.main.async {
                    self.getUserData()
                    self.view.hideLoader()
                }
            }
        
    }
    
}
