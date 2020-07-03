//
//  FirstViewModel.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 02/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import Foundation
import UIKit

class FirstViewModel {
    func managedCollectionViewTapped(view: FirstScreenVC) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManagedCollectionVC") as? ManagedCollectionVC {
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func downloadFilePopUp(view: FirstScreenVC) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DownloadFilesViewC") as? DownloadFilesViewC {
            vc.providesPresentationContextTransitionStyle = true
            vc.definesPresentationContext = true
            vc.modalPresentationStyle = .overCurrentContext
            vc.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            view.present(vc, animated: true, completion: nil)
        }
    }
    
    func showlogInScreen(viewC: FirstScreenVC) {
        print("Login button tapped")
    }
    
    func showTrackMeScreen(viewC: FirstScreenVC) {
        print("TrackMe button Tapped")
    }
    
    func showLayoutScreen(viewC: FirstScreenVC) {
        if let vc = UIStoryboard(name: "Layout", bundle: nil).instantiateViewController(withIdentifier: "CreateLayoutViewC") as? CreateLayoutViewC {
            viewC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
