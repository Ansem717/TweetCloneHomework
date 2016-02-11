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
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        setupTweet()
    }
    
    func setupTweet()
    {
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.originalTweet, originalUser = originalTweet.user {
                self.navigationItem.title = "Retweet"
                self.tweetText.text = originalTweet.text
                self.userLabel.text = "author: originalUser.name"
                self.profileImage(originalUser.profileImageUrl, completion: { (image) -> () in
                    self.profileImageView.image = image
                }
            } else {
                self.singleTweet.text = tweet.text
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
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UserTimelineViewController"
        {
            let utvc = segue.destinationViewController as! UserTimelineViewController
            utvc.tweet = self.tweet
        }
    }
    
}

























