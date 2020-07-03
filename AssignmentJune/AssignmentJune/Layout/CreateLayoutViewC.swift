//
//  CreateLayoutViewC.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 03/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import UIKit

class CreateLayoutViewC: UIViewController {
    
    var viewModel: CreateLayoutViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateLayoutViewModel(delegate: self)
        self.title = "Layout"
        // Do any additional setup after loading the view.
    }

}

extension CreateLayoutViewC: CreateLayoutViewModelDelegate {
    
}
