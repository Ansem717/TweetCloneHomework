//
//  UserTimelineViewController.swift
//  TweetCloneHomework
//
//  Created by Andy Malik on 2/11/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController
{
    var tweet: Tweet?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let tweet = self.tweet, username = tweet.user?.screenName {
            API.shared.GETUserTweets(username, completion: { (tweets) -> () in
                if let tweets = tweets {
                    for tweet in tweets {
                        print(tweet.text) //Displaying wrong user?
                    }
                }
            })
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
