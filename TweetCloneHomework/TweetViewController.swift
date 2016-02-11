//
//  TweetViewController.swift
//  TweetCloneHomework
//
//  Created by Andy Malik on 2/10/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var singleTweet: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    var tweet: Tweet?
    
    static func identifier () -> String {
        return "TweetViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTweet()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTweet()
    {
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.originalTweet, originalUser = originalTweet.user {
                self.navigationItem.title = "Retweet"
                self.singleTweet.text = originalTweet.text
                self.userLabel.text = originalUser.name
                self.profileImage(originalUser.profileImageURL, completion: { (image) -> () in
                    self.userImg.image = image
                })
            } else {
                self.navigationItem.title = "Tweet"
                self.singleTweet.text = tweet.text
                self.userLabel.text = user.name
                self.profileImage(user.profileImageURL, completion: { (image) -> () in
                    self.userImg.image = image
                })
            }
        }
    }
    
    func profileImage(key: String, completion: (image: UIImage) -> ())
    {
        if let image = SimpleCache.shared.getImage(key){
            completion(image: image)
            return
        }
        
        API.shared.GETImage(key) { (image) -> () in
            completion(image: image)
        }
    }
    
    func setupAppearance() {
        self.userImg.layer.cornerRadius = 50
        self.userImg.clipsToBounds = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UserTimelineViewController"
        {
            let utvc = segue.destinationViewController as! UserTimelineViewController
            utvc.tweet = self.tweet
        }
    }
    
}

























