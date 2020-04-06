//
//  LoginViewController.swift
//  Capital Social
//
//  Created by Jose Vargas on 05/04/20.
//  Copyright © 2020 joscompany. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, loginValidatorDelegate {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var registrateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrateBtnConfig()
    }
    
    @IBAction func btnIngresarPressed(_ sender: Any) {
        CustomActivityIndicator.start()
        let loginValidator = LoginValidator()
        loginValidator.delegate = self
        loginValidator.validateUserPass(username: self.userTextField.text!)
    }
    
    @IBAction func btnScanQR(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "scanQRstoryboard")
        self.present(controller!, animated: true, completion: nil)
    }
    
    func loginValidated(response: Bool, message: String) {
        print("\(message)")
        if response {
            CustomActivityIndicator.stop()
            let controller = storyboard?.instantiateViewController(withIdentifier: "navigationViewController")
            self.present(controller!, animated: true, completion: nil)
        } else {
            CustomActivityIndicator.stop()
            self.showAlert(title: "Algo salió mal", message: message, style: .cancel)
        }
    }
    
    func registrateBtnConfig() {
        registrateBtn.layer.borderWidth = 2
        registrateBtn.layer.borderColor = UIColor.pinklight.cgColor
    }
}
