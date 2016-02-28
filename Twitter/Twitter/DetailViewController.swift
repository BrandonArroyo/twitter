//
//  DetailViewController.swift
//  Twitter
//
//  Created by Brandon Arroyo on 2/27/16.
//  Copyright © 2016 Brandon Arroyo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet: Tweet?
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var screenName: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var createdTime: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var likedCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.setImageWithURL((tweet?.user?.profileUrl)!)
        screenName.text = tweet!.user?.screenname as! String
        name.text = tweet!.user?.name as! String
        var timeString = tweet!.timeStampString
        timeString?.removeRange(Range<String.Index>(start: timeString!.endIndex.advancedBy(-10),end: timeString!.endIndex))
        createdTime.text = timeString
        tweetContent.text = tweet!.text
      
        retweetCount.text = String(tweet!.retweetOCount!)
        likedCount.text = String(tweet!.favoritesOcount!)
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
