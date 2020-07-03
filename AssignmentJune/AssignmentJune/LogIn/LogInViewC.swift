//
//  ViewController.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 29/06/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var textFieldNumber: UITextField!
    

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textFieldNumber.keyboardType = .numberPad
    }
    
    //MARK: - IBActions
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let textfeild = textFieldNumber.text, textfeild != "" else {return}
        Auth.auth().languageCode = "En";
        PhoneAuthProvider.provider().verifyPhoneNumber("+91" + textfeild, uiDelegate: nil) { (verificationID, error) in
          if let error = error {
            SwiftHelper.showOkAlertFor(title: "Error!", message: error.localizedDescription, obj: self, completion: nil)
            return
          }
            UserDefaults.standard.set(verificationID, forKey: Constant.kAuthVerificationID)
            self.showVerificationPopUp()
            
        }
    }
    
    func showVerificationPopUp() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let verificationVC = storyBoard.instantiateViewController(identifier: "VarificationNumberViewC") as? VarificationNumberViewC {
            self.navigationController?.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.navigationController?.present(verificationVC, animated: true, completion: nil)

            }
        }
    }


}

