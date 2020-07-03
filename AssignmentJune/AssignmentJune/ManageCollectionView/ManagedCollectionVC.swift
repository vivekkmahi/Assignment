//
//  ManagedCollectionVC.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 02/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import UIKit

class ManagedCollectionVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var textFieldNoOFCell: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var noOfCell = 0
    var model: ManageCollectionViewModel?
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ManageCollectionViewModel()
        self.title = "Manage Collection View"
        textFieldNoOFCell.keyboardType = .numberPad
        collectionView.collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBOutlets
    @IBAction func applytapped(_ sender: Any) {
        self.noOfCell = model?.getNumberOfCell(text: textFieldNoOFCell.text ?? "") ?? 0
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
    }
    
    
}

extension ManagedCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrototypeCollectionCell", for: indexPath) as? PrototypeCollectionCell {
            cell.settext(indexPath.row + 1)
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (indexPath.row + 1) * 10
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
     
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
