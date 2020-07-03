//
//  DownloadFilesViewModel.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 02/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import Foundation
import UIKit

protocol DownloadFilesViewModelDelegate {
    func getProgress(indexRow: Int, progress: Float)
    func gotError(message: String)
}

class DownloadFilesViewModel: NSObject {
    
    var delegate: DownloadFilesViewModelDelegate?
    var downloadTaskQueue = [URLSessionDownloadTask]()
//    private lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    
    init(delegate: UIViewController) {
        self.delegate = delegate as? DownloadFilesViewModelDelegate
    }
    
    func getDownload(stringUrl: String) {
        if let url = URL(string: stringUrl), UIApplication.shared.canOpenURL(url) {
            urlsessionForDownload(url: url)
        }else {
            delegate?.gotError(message: "Invalid Url")
        }
        
    }
    
    private func urlsessionForDownload(url: URL) {
//        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
//        let downloadTask = urlSession.downloadTask(with: url)
//        downloadTaskQueue.append(downloadTask)
//        downloadTask.resume()
        
        
        let downloadTask = URLSession.shared.downloadTask(with: url) {
            urlOrNil, responseOrNil, errorOrNil in
            // check for and handle errors:
            // * errorOrNil should be nil
            // * responseOrNil should be an HTTPURLResponse with statusCode in 200..<299
            
            guard let fileURL = urlOrNil else { return }
            do {
                let documentsURL = try
                    FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
            } catch {
                print ("file error: \(error)")
                self.delegate?.gotError(message: error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.delegate?.getProgress(indexRow: 0, progress: 1)
            }
        }
        downloadTask.resume()
    }
}

extension DownloadFilesViewModel: URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        if downloadTaskQueue.contains(downloadTask), let row = downloadTaskQueue.firstIndex(of: downloadTask) {
            
            let calculatedProgress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            DispatchQueue.main.async {
                //                self.progressLabel.text = self.percentFormatter.string(from:
                //                    NSNumber(value: calculatedProgress))
                self.delegate?.getProgress(indexRow: row, progress: calculatedProgress)
            }
        }
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        guard (downloadTask.originalRequest?.url) != nil else {
            self.delegate?.gotError(message: "Download Failed")
            return}

        do {
            let documentsURL = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            let savedURL = documentsURL.appendingPathComponent(
                location.lastPathComponent)
            try FileManager.default.moveItem(at: location, to: savedURL)
        } catch {
            self.delegate?.gotError(message: error.localizedDescription)
            return
        }
        if downloadTaskQueue.contains(downloadTask), let row = downloadTaskQueue.firstIndex(of: downloadTask) {
            DispatchQueue.main.async {
                self.delegate?.getProgress(indexRow: row, progress: 1)
            }
        }
    }
}
