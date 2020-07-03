//
//  CreateLayoutViewModel.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 03/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//


protocol CreateLayoutViewModelDelegate {
    
}
import Foundation
import UIKit

class CreateLayoutViewModel {
     
    var delegate: CreateLayoutViewModelDelegate?
    
    init(delegate: UIViewController) {
        self.delegate = delegate as? CreateLayoutViewModelDelegate
    }
}
