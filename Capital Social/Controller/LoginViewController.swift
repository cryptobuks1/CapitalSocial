//
//  LoginViewController.swift
//  Capital Social
//
//  Created by Jose Vargas on 05/04/20.
//  Copyright © 2020 joscompany. All rights reserved.
//

import UIKit

import AVFoundation
import QRCodeReader

class LoginViewController: UIViewController, loginValidatorDelegate, QRCodeReaderViewControllerDelegate {
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var registrateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTextField.delegate = self
        registrateBtnConfig()
    }
    
    @IBAction func btnIngresarPressed(_ sender: Any) {
        CustomActivityIndicator.start()
        let loginValidator = LoginValidator()
        loginValidator.delegate = self
        loginValidator.validateUserPass(username: self.userTextField.text!)
    }
    
    @IBAction func btnScanQR(_ sender: Any) {
        scanAction()
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
    
    func scanAction() {
        // Retrieve the QRCode content
         // By using the delegate pattern
         readerVC.delegate = self

         // Or by using the closure pattern
         readerVC.completionBlock = { (result: QRCodeReaderResult?) in
           print(result)
         }

         // Presents the readerVC as modal form sheet
         readerVC.modalPresentationStyle = .formSheet
        
         present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()

        dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    /**
      * Called when 'return' key pressed. return NO to ignore.
      */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }


    /**
     * Called when the user click on the view (outside the UITextField).
     */
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
         self.view.endEditing(true)
     }
}
