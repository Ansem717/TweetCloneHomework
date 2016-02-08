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
    
    init(name: String, profileImageURL: String, location: String)
    {
        self.name = name
        self.profileImageURL = profileImageURL
        self.location = location
    }
    
}