//
//  user.swift
//  TweetCloneHomework
//
//  Created by Allen Hurst on 2/8/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import Foundation


class User
{
    
    let name: String
    let profileImageURL: String
    let location: String
    let screenName: String
    
    init(name: String, profileImageURL: String, location: String, screenName: String)
    {
        self.name = name
        self.profileImageURL = profileImageURL
        self.location = location
        self.screenName = screenName
    }
}