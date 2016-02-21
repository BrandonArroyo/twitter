//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Brandon Arroyo on 2/20/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        TwitterClient.sharedInstance.home_timeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    
    
    @available(iOS 2.0, *)
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let tweets = self.tweets{
            return tweets.count
        }else{
            return 0
        }

    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell  = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweets![indexPath.row]
        
        
        
//        @IBOutlet weak var screenName: UILabel!
//        
//        @IBOutlet weak var name: UILabel!
//        
//        @IBOutlet weak var createdAt: UILabel!
//        
//        @IBOutlet weak var tweetContent: UILabel!
//        
//        @IBOutlet weak var retweetCount: UILabel!
//        
//        @IBOutlet weak var favoriteCount: UILabel!
//        
//        @IBOutlet weak var profilePicture: UIImageView!

        cell.tweetContent.text = tweet.text
        cell.screenName.text = tweet.user!.screenname! as String
        cell.name.text = "@\(tweet.user!.name!)"
        cell.createdAt.text = convertTimeToString(Int(NSDate().timeIntervalSinceDate(tweet.timeStamp!)))
        cell.name.text = "@\(tweet.user!.name!)"
        cell.retweetCount.text = String(tweet.retweetCount)
        cell.favoriteCount.text = String(tweet.favoritesCount)
        cell.profilePicture.setImageWithURL((tweet.user?.profileUrl)!)
        
        
        
        return cell
    }
    func convertTimeToString(number: Int) -> String{
        let day = number/86400
        let hour = (number - day * 86400)/3600
        let minute = (number - day * 86400 - hour * 3600)/60
        if day != 0{
            return String(day) + "d"
        }else if hour != 0 {
            return String(hour) + "h"
        }else{
            return String(minute) + "m"
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
