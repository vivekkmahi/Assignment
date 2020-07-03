//
//  FirstScreenVC.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 02/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import UIKit

class FirstScreenVC: UIViewController {

    var model: FirstViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model = FirstViewModel()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func logInTapped(_ sender: Any) {
        model?.showLayoutScreen(viewC: self)
    }
    
    @IBAction func tackedMeTapped(_ sender: Any) {
        model?.showTrackMeScreen(viewC: self)
    }
    
    @IBAction func managedCollectionTapped(_ sender: Any) {
        model?.managedCollectionViewTapped(view: self)
    }
    
    @IBAction func DownloadFileTapped(_ sender: Any) {
        model?.downloadFilePopUp(view: self)
    }
    
    @IBAction func createLayoutTapped(_ sender: Any) {
        model?.showLayoutScreen(viewC: self)
    }
    
}
