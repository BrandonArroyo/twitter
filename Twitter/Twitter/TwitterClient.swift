//
//  TwitterClient.swift
//  Twitter
//
//  Created by Brandon Arroyo on 2/14/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



let twitterConsumerKey = "Sajwz1vrdrDPYWxc5v4u7JmsF"
let twitterConsumerSecret = "sn5KzGM3odqcAOpQkSxccBTWo7Ns36SzQWbiwWYAVAfxjMX6O2"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient{
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    func handleOpenUrl(url: NSURL){
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
                print("got it")
            self.current_account({ (user:User) -> () in
                    User.currentUser = user 
                    self.loginSuccess?()
            }, failure: { (error: NSError) -> () in
                        self.loginFailure?(error)
            })
            
                self.loginSuccess?()
            
            }){
                (error: NSError!) -> Void in
                print("error:\(error.localizedDescription)")
                self.loginFailure?(error)
        }
        
        
        
        
    }
    func login(success:()->(),failure: (NSError)-> ()) {
        loginSuccess =  success
        loginFailure = failure
        
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            var authURL =  NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print(error.description)
                self.loginFailure?(error)
        }
        
    }
    func logout(){
        User.currentUser = nil
        deauthorize() 
    }
    
    func home_timeline(success: ([Tweet]) -> (), failure: (NSError) -> () ){
        GET("1.1/statuses/home_timeline.json", parameters: nil,
            success: {(operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let dictionaries = response as! [NSDictionary]
                
                let tweets = Tweet.tweetsWithArray(dictionaries)
                success(tweets)
                
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    
    
    
    
    func current_account(success: (User)->(), failure: (NSError)->()){
        GET("1.1/account/verify_credentials.json", parameters: nil,
            success: {(operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let userDictionary = response as! NSDictionary
                
                let user = User(dictionary: userDictionary)
                success(user)
                print("user \(user) ")
                print("name: \(user.name) ")
                print("screen_name: \(user.screenname) ")
                print("profile_url: \(user.profileUrl) ")
                print("descrption: \(user.tagline) ")
                
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error")
                failure(error)
            })
        
        
    }
    
  

}
