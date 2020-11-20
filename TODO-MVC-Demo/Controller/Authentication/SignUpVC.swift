//
//  SignUpVC.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 10/28/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userAgeTextField: UITextField!
    
    // MARK:- Properties
    var presenter: SignUpPresenter!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceHolders()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.presenter = SignUpPresenter(view: signUpVC)
        return signUpVC
    }
    
    
    
    // MARK:- Actions
    @IBAction func signUpSubmittBtn(_ sender: UIButton) {
       presenter.signUpUser(name: userNameTextField.text!, email: userEmailTextField.text!, password: userPasswordTextField.text!, age: userAgeTextField.text!)
    }
    
    @IBAction func signInBtn(_ sender: UIButton) {
        goToSignInVC()
    }
}
// MARK:- Extension Private Functions
extension SignUpVC{
    
    private func setPlaceHolders(){
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        userEmailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        userPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        userAgeTextField.attributedPlaceholder = NSAttributedString(string: "Age", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    
}

// MARK:- extension SignUp Presenter
extension SignUpVC{
    func showAlert(alertTitle: String, message: String, actionTitle: String) {
        ShowAlertsManager.showAlertWithCancel(alertTitle: alertTitle, message: message, actionTitle: actionTitle)
    }
    
    func goToSignInVC() {
        let signInVC = SignInVC.create()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    
}
