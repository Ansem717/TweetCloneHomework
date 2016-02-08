//
//  tweet.swift
//  TweetCloneHomework
//
//  Created by Allen Hurst on 2/8/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import Foundation


class Tweet
{
    
    let id: Int
    let text: String
    let user: User?
    
    init(id: Int, text: String, user: User? = nil)
    {
        self.id = id
        self.text = text
        self.user = user
    }
    
    
}