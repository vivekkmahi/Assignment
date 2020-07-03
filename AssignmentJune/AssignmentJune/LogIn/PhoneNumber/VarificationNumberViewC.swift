//
//  VarificationNumberViewC.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 01/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import UIKit
import FirebaseAuth

class VarificationNumberViewC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var textFeildVerificationNumber: UITextField!
    

    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - IBOutlets
    @IBAction func verifyButtonTapped(_ sender: Any) {
        let verificationID = UserDefaults.standard.string(forKey: Constant.kAuthVerificationID)
        
        if let textFeildNumber = textFeildVerificationNumber.text, textFeildNumber != "", let verificationID = UserDefaults.standard.string(forKey: Constant.kAuthVerificationID) {
            let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: textFeildNumber)
        }
    }
    
    
//    func doAuthentication(credential: PhoneAuthCredential) {
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//          if let error = error {
//            let authError = error as NSError
//            if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
//              // The user is a multi-factor user. Second factor challenge is required.
//              let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
//              var displayNameString = ""
//              for tmpFactorInfo in (resolver.hints) {
//                displayNameString += tmpFactorInfo.displayName ?? ""
//                displayNameString += " "
//              }
//              self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
//                var selectedHint: PhoneMultiFactorInfo?
//                for tmpFactorInfo in resolver.hints {
//                  if (displayName == tmpFactorInfo.displayName) {
//                    selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
//                  }
//                }
//                PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
//                  if error != nil {
//                    print("Multi factor start sign in failed. Error: \(error.debugDescription)")
//                  } else {
//                    self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
//                      let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
//                      let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
//                      resolver.resolveSignIn(with: assertion!) { authResult, error in
//                        if error != nil {
//                          print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
//                        } else {
//                          self.navigationController?.popViewController(animated: true)
//                        }
//                      }
//                    })
//                  }
//                }
//              })
//            } else {
//              self.showMessagePrompt(error.localizedDescription)
//              return
//            }
//            // ...
//            return
//          }
//          // User is signed in
//          // ...
//        }
//    }
    
}
