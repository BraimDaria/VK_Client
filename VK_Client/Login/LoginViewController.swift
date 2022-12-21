//
//  ViewController.swift
//  VK_Client
//
//  Created by  Daria on 15.10.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let singleton = Session.shared
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
     
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//
//    let checkResult = checkUserData()
//    if !checkResult { showLoginError()
//    }
//    return checkResult }
//    func checkUserData() -> Bool {
//    guard let login = userNameTextField.text,
//    let password = passwordTextField.text else { return false }
//    if login == "admin" && password == "123456" { return true
//    } else {
//    return false
//    } }
//    func showLoginError() {
//    let alert = UIAlertController(title: "Ошибка авторизации", message: "Введены неверные данные", preferredStyle: .alert)
//        let okButton = UIAlertAction(title: "OK", style: .default) { _ in  self.userNameTextField.text?.removeAll()
//            self.passwordTextField.text = ""
//        }
//
//    alert.addAction(okButton)
//    present(alert, animated: true) }
    
}

