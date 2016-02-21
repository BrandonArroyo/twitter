//
//  Tweet.swift
//  Twitter
//
//  Created by Brandon Arroyo on 2/20/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: User?
    var dictionary: NSDictionary
    var hasRetweeted = false
    var hasFavorated = false
    var tweetID: String?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        text = dictionary["text"] as! String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
    
        
        if let timeStampString = timeStampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat =  "EEE MMM d HH:mm:ss Z y"
            timeStamp =  formatter.dateFromString(timeStampString)
        }
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        tweetID = dictionary["id_str"] as? String
        
        hasFavorated = dictionary["favorited"] as! Bool
        hasRetweeted = dictionary["retweeted"] as! Bool
        
      
    }
    class func tweetsWithArray(dictionaries:[NSDictionary])->[Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet =  Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}

