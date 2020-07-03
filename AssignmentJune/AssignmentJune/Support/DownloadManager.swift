//
//  DownloadManager.swift
//  AssignmentJune
//
//  Created by Ravindra Sonkar on 03/07/20.
//  Copyright © 2020 Vivek Kumar. All rights reserved.
//

import Foundation
import UIKit

protocol DownloadManagerDelegate {
    func backgroundProgress(progress: Double, session: URLSession)
    func backgroundComplete(session: URLSession, downloadTask: URLSessionDownloadTask, location: URL)
}
class DownloadManager: NSObject {
   static let shared = DownloadManager()
    var delegate: DownloadManagerDelegate?
    
    private lazy var bgSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: Constant.kBackgroundSession)
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload(urlString: String) {
        if let url = URL(string: urlString) {
            let bgTask = bgSession.downloadTask(with: url)
            bgTask.earliestBeginDate = Date().addingTimeInterval(2 * 60)
            bgTask.countOfBytesClientExpectsToSend = 512
            bgTask.countOfBytesClientExpectsToReceive = 1 * 1024 * 1024 * 1024 // 1GB
            bgTask.resume()
        }
    }
}
extension DownloadManager: URLSessionDelegate, URLSessionDownloadDelegate
{
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.bgSessionCompletionHandler
                else {
                    return
            }
            appDelegate.bgSessionCompletionHandler = nil
            completionHandler()
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Did finish downloading: \(location.absoluteString)")
        DispatchQueue.main.async {
//            self.onCompleted?(location)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else {
            return
        }
        
        let progress = Double(Double(totalBytesWritten)/Double(totalBytesExpectedToWrite))
        print("Download progress: \(progress)")
        DispatchQueue.main.async {
//            self.onProgress?(progress)
        }
    }
}
