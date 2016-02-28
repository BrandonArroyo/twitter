//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Brandon Arroyo on 2/27/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit




class NewTweetViewController: UIViewController {

    @IBOutlet weak var TweetContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
        
        }
    }

    @IBAction func onSendTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.sendTweet(TweetContent.text, params: nil) { (tweet, error) -> () in
            if (error == nil){
                
                
//                theseTweets?.insert(tweet!, atIndex: 0)
              
                self.dismissViewControllerAnimated(true) { () -> Void in
                    
                }
                
                
            }else{
                print(error?.localizedDescription)
                let alert = UIAlertController(title: nil, message: "Tweet Update Failed", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
                self.presentViewController(alert,animated: true,completion: nil)
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
