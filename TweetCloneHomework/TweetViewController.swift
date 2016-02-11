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
        if let tweet = self.tweet {
            self.singleTweet.text = tweet.text
        }
    }
}
