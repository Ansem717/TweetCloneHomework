//
//  TweetJSONParser.swift
//  TweetCloneHomework
//
//  Created by Allen Hurst on 2/8/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets:[Tweet]?) -> ()

class TweetJSONParser
{
    class func tweetJSONFrom
    {
        
    }
    
    class func userFromTweetJSON(tweetJSON: [String : AnyObject]) -> User
    {
        guard let name = tweetJSON["name"] as? String else { fatalError("Failed to parse name") }
        guard let profileImageURL = tweetJSON["profile_image_url"] as? String else { fatalError("Failed to parse profile image") }
        guard let location = tweetJSON["location"] as? String else { fatalError("Failed to parse location") }
        
        return User(name: name, profileImageURL: profileImageURL, location: location)
        
    }
    
    class func JSONData() -> NSData
    {
        
    }
}