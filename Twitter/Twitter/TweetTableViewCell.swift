//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Brandon Arroyo on 2/20/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var screenName: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
    
    @IBOutlet weak var profilePicture: UIImageView!
    

    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var retweetImage: UIImageView!
    
    var tweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
