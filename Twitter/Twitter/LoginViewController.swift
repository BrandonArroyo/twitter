//
//  ViewController.swift
//  Twitter
//
//  Created by Brandon Arroyo on 2/14/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager



class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        let client = TwitterClient.sharedInstance
        client.login({ () -> () in
            print("Logged in now")
            }) { (error: NSError) -> () in
                print("error: \(error.localizedDescription)")
        }
     
    }

}

