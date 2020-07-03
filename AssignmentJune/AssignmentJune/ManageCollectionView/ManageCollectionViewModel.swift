//
//  ManageCollectionModel.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 02/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import Foundation
import UIKit

class ManageCollectionViewModel {
    
    func getNumberOfCell(text: String) -> Int {
        if let cellCount = Int(text) {
        return cellCount
        }
        return 0
    }
}
