//
//  RegisterViewController.swift
//  todo-app
//
//  Created by Michael Florendo on 08/11/2018.
//  Copyright © 2018 Michael Florendo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    //MARK: Properties
    var presenter : RegisterPresenter? 
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = RegisterPresenter(delegate: self)
    }
    
    @IBAction func buttonRegisterTapped(_ sender: Any) {
        let email = textFieldEmail.text ?? ""
        let name = textFieldName.text ?? ""
        let password = textFieldPassword.text ?? ""
        let confirmPassword = textFieldConfirmPassword.text ?? ""
        
        let isRegistered = self.presenter?.register(name: name, email: email, password: password, confirmPassword: confirmPassword)
        
        if isRegistered == true {
            print("Success")
        }
    }
    @IBAction func buttonCancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegisterViewController: RegisterDelegate {
    func registrationFailed(message: String) {
    }
    
    func registrationSuccess(message: String) {
        
    }
    
}
