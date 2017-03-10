//
//  NotificationViewController.swift
//  CustomNotification
//
//  Created by Rajat Bhatt on 2/28/17.
//  Copyright © 2017 Rajat Bhatttixdo. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet var label: UILabel?
    @IBOutlet weak var notificationImage: UIImageView!
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        session = URLSession.shared
        task = URLSessionDownloadTask()
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.userInfo["title"] as! String?
        if let urlString = notification.request.content.userInfo["image"] as! String? {
            if let imageURL = URL(string: urlString) {
                if let data = NSData(contentsOf: imageURL) {
                    self.notificationImage.image = UIImage(data: data as Data)
                }
            }
        }
//        if let bestAttemptContent = bestAttemptContent {
//            // Modify the notification content here...
//            
//            // Get the custom data from the notification payload
//            
//            if let notificationData = bestAttemptContent.userInfo["data"] as? [String: String] {
//                
//                // Grab the attachment
//                if let urlString = bestAttemptContent.userInfo["image"], let fileUrl = URL(string: urlString as! String) {
//                    if let data = NSData(contentsOf: fileUrl) {
//                        self.notificationImage.image = UIImage(data: data as Data)
//                    }
//                    
//                }
//            }
//        }
    }
    
    func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.label?.text = "1000"//request.content.userInfo["title"] as! String?
        
        //        self.contentHandler = contentHandler
        //        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        //        print(request.content)
        //        if let bestAttemptContent = bestAttemptContent {
        //            // Modify the notification content here...
        //
        //            // Get the custom data from the notification payload
        //
        //            if let notificationData = bestAttemptContent.userInfo["data"] as? [String: String] {
        //
        //                // Grab the attachment
        //                if let urlString = bestAttemptContent.userInfo["attachment-url"], let fileUrl = URL(string: urlString as! String) {
        //
        //
        //                    // Download the attachment
        //                    URLSession.shared.downloadTask(with: fileUrl) { (location, response, error) in
        //                        if let location = location {
        //
        //                            // Move temporary file to remove .tmp extension
        //                            let tmpDirectory = NSTemporaryDirectory()
        //                            let tmpFile = "file:".appending(tmpDirectory).appending(fileUrl.lastPathComponent)
        //                            let tmpUrl = URL(string: tmpFile)!
        //                            try! FileManager.default.moveItem(at: location, to: tmpUrl)
        //
        //                            // Add the attachment to the notification content
        //                            if let attachment = try? UNNotificationAttachment(identifier: "", url: tmpUrl) {
        //                                self.bestAttemptContent?.attachments = [attachment]
        //                            }
        //                        }
        //
        //                        // Serve the notification content
        //                        self.contentHandler!(self.bestAttemptContent!)
        //                        }.resume()
        //                }
        //            }
        //        }
    }
    
    func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
}
