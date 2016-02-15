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

}
