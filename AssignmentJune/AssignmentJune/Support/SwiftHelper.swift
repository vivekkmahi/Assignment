//
//  SwiftHelper.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 01/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import SVProgressHUD
import SystemConfiguration

let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate

struct SwiftHelper {
    static func showOkAlertFor(title: String, message: String, obj: UIViewController?, completion: ((_ tag: Int) -> Void)?) {
      DispatchQueue.main.async {
//        SVProgressHUD.dismiss()
        if message == "" {
            return
        }
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: { (_) in
            if completion != nil {
                completion!(0)
            }
        }))
        if obj != nil {
            DispatchQueue.main.async {
                obj!.present(alert, animated: true, completion: {})
            }
        } else {
            DispatchQueue.main.async {
                scene?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
      }
    }
    
    static func showAlertView(title: String, otherButtonTitle: String, message: String, obj: UIViewController?, completion: @escaping (_ tag: Int) -> Void) {
//      self.dismissLoader()
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "cancel", style: UIAlertAction.Style.default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
            completion(0)
        }))
        alert.addAction(UIAlertAction.init(title: otherButtonTitle, style: UIAlertAction.Style.default, handler: { (_) in
            completion(1)
        }))
        if obj != nil {
            DispatchQueue.main.async {
                obj!.present(alert, animated: true, completion: {})
            }
        } else {
            DispatchQueue.main.async {
                scene?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    static func isLoaderVisible() -> Bool {
       return SVProgressHUD.isVisible()
    }
    
    static func showLoader(message: String? = "") {
      DispatchQueue.main.async {
        if SVProgressHUD.isVisible() {
          SVProgressHUD.dismiss()
        }
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.setForegroundColor(.systemPurple)
        SVProgressHUD.setContainerView(scene?.window)
        SVProgressHUD.setMaximumDismissTimeInterval(40)
        SVProgressHUD.show()
      }
    }
    
    static func dismissLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
}
