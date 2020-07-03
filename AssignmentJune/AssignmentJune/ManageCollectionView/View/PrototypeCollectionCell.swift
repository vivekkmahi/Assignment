//
//  PrototypeCollectionCell.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 02/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import UIKit

class PrototypeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var labellNo: UILabel!
    
    func settext(_ number: Int) {
        labellNo.text = "\(number)"
    }
    
}
