//
//  DownloadFilesViewC.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 02/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import UIKit

class DownloadFilesViewC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var textFieldUrl: UITextField!
    //MARK: - Variables
    var model: DownloadFilesViewModel?

    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        model = DownloadFilesViewModel(delegate: self)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func tappedDownload(_ sender: Any) {
        labelError.text = ""
        if let urlString = textFieldUrl.text, urlString != "" {
            model?.getDownload(stringUrl: urlString)
        }
    }
    
    @IBAction func crossTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DownloadFilesViewC: DownloadFilesViewModelDelegate {
    func getProgress(indexRow: Int, progress: Float) {
        DispatchQueue.main.async {
            self.labelError.textColor = .blue
            if progress < 1 {
                self.labelError.text = "Downloading..  " + "\(progress * 100)%"
            }else {
                self.labelError.text = "Download Complete " + "\(progress * 100)%"
                self.textFieldUrl.text = ""
            }
        }
    }
    
    func gotError(message: String) {
        DispatchQueue.main.async {
            self.labelError.textColor = .red
            self.labelError.text = "* " + message
        }
    }
    
    
}
