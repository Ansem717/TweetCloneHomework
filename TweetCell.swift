//
//  TweetCell.swift
//  TweetCloneHomework
//
//  Created by Andy Malik on 2/11/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    var tweet: Tweet! {
        didSet {
            self.tweetText.text = self.tweet.text
            self.userLabel.text = self.tweet.user?.name
            
            if let user = self.tweet.user {
                if let image = SimpleCache.shared.getImage(user.profileImageURL)  {
                    self.imgView.image = image
                    return
                }
                
                API.shared.GETImage(user.profileImageURL, completion: { (image) -> () in
                    self.imgView.image = image
                })
                
            }
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.setupTweetCell()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func setupTweetCell()
    {
        self.imgView.clipsToBounds = true
        self.imgView.layer.cornerRadius = 30
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.layoutMargins = UIEdgeInsetsZero
        
        
        
    }
}





























