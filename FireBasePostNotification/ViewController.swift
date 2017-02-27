//
//  ViewController.swift
//  FireBasePostNotification
//
//  Created by Rajat Bhatt on 2/16/17.
//  Copyright © 2017 Rajat Bhatttixdo. All rights reserved.
//

import UIKit
import FirebaseInstanceID
import FirebaseMessaging

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogTokenTouch(_ sender: UIButton) {
        // [START get_iid_token]
        let token: String = FIRInstanceID.instanceID().token()!
        print("InstanceID token: \(token)")
        // [END get_iid_token]
    }
    @IBAction func handleSubscribeTouch(_ sender: UIButton) {
        // [START subscribe_topic]
        FIRMessaging.messaging().subscribe(toTopic: "/topics/post")
        print("Subscribed to news topic")
        // [END subscribe_topic]
    }
    
}

