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
    var refreshControl: UIRefreshControl!
    
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
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

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
        cell.tweet = tweet
        
        
        let retweetTapAction = UITapGestureRecognizer(target: self, action: "retweet:")
            cell.retweetImage.tag = indexPath.row
            cell.retweetImage.userInteractionEnabled = true
            cell.retweetImage.addGestureRecognizer(retweetTapAction)
        if tweet.hasRetweeted{
            cell.retweetImage.highlighted = true
        }
        
//        
        let favorateTapAction = UITapGestureRecognizer(target: self, action: "favorate:")
        cell.favoriteImage.tag = indexPath.row
        cell.favoriteImage.userInteractionEnabled = true
        cell.favoriteImage.addGestureRecognizer(favorateTapAction)
        if tweet.hasFavorated{
            cell.favoriteImage.highlighted = true
        }
        
        cell.selectionStyle = .None
        
        
        
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
    
    
    func onRefresh(){
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
        TwitterClient.sharedInstance.home_timeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }) { (error: NSError) -> () in
                
        }

 
        refreshControl.endRefreshing()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
//    
    func retweet(sender: UITapGestureRecognizer){
        print("clicked")
        if sender.state != .Ended{
            return
        }
//
        let index = sender.view?.tag
  
        if let index = index{
            print(index)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! TweetTableViewCell
            if (!cell.tweet!.hasRetweeted){
                print("tet")
                TwitterClient.sharedInstance.retweetWithTweetID(tweets![index].tweetID!, params: nil, completion: { (response, error) -> () in
                    if (error == nil){
                        self.tweets![index].retweetCount += 1
                        self.tweets![index].hasRetweeted = true
                        cell.retweetCount.text = String(Int(cell.retweetCount.text!)! + 1)
                        cell.tweet!.hasRetweeted = true
                        cell.retweetImage.highlighted = true
                    }else{
                        print("Retweeted fail: \(error!.description)")
                    }
                })
            }else{
                    print("im trying asdfasd adsfa")
                TwitterClient.sharedInstance.unRetweetWithTweetID(tweets![index].tweetID!, params: nil, completion: { (response, error) -> () in
                    if (error == nil){
                        self.tweets![index].retweetCount -= 1
                        self.tweets![index].hasRetweeted = false
                        cell.retweetCount.text = String(Int(cell.retweetCount.text!)! - 1)
                        cell.tweet!.hasRetweeted = false
                        cell.retweetImage.highlighted = false
                    }else{
                        print("Unretweeted fail: \(error!.description)")
                    }
                })
            }
        }
    }
//
    func favorate(sender: UITapGestureRecognizer){
        if sender.state != .Ended{
            return
        }
        let index = sender.view?.tag
        if let index = index{
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! TweetTableViewCell
            if (!cell.tweet!.hasFavorated){
                TwitterClient.sharedInstance.favoratedWithTweetID(tweets![index].tweetID!, params: nil, completion: { (response, error) -> () in
                    if (error == nil){
                        self.tweets![index].favoritesCount += 1
                        self.tweets![index].hasFavorated = true
                        cell.favoriteCount.text = String(Int(cell.favoriteCount.text!)! + 1)
                        cell.tweet!.hasFavorated = true
                        cell.favoriteImage.highlighted = true
                    }else{
                        print("favorated fail: \(error!.description)")
                    }
                })
            }else{
                TwitterClient.sharedInstance.unFavoratedWithTweetID(tweets![index].tweetID!, params: nil, completion: { (response, error) -> () in
                    if (error == nil){
                        self.tweets![index].favoritesCount -= 1
                        self.tweets![index].hasFavorated = false
                        cell.favoriteCount.text = String(Int(cell.favoriteCount.text!)! - 1)
                        cell.tweet!.hasFavorated = false
                        cell.favoriteImage.highlighted = false
                    }else{
                        print("unfavorated fail: \(error!.description)")
                    }
                })
            }
        }
        
    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
