//
//  User.swift
//  Twitter
//
//  Created by Brandon Arroyo on 2/20/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    init(dictionary: NSDictionary){
//        print("user \(user) ")
//        print("name: \(user["name"]) ")
//        print("screen_name: \(user["screen_name"]) ")
//        print("profile_url: \(user["profile_image_url_https"]) ")
//        print("descrption: \(user["description"]) ")
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
            
        }
        tagline  = dictionary["description"] as? String

    }

}
