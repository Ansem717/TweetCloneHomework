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
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion)
    {
        
        NSOperationQueue().addOperationWithBlock { () -> Void in
            
            do {
                if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String : AnyObject]] {
                    
                    var tweets = [Tweet]()
                    
                    for tweetJSON in rootObject {
                        if let
                            text = tweetJSON["text"] as? String,
                            id = tweetJSON["id"] as? Int,
                            userJSON = tweetJSON["user"] as? [String : AnyObject] {
                                
                                let user = self.userFromTweetJSON(userJSON)
                                let tweet = Tweet(id: id, text: text, user: user)
                                
                                tweets.append(tweet)
                        }
                        
                    }
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        completion(success: true, tweets: tweets)
                    })
                }
            } catch _ { completion(success: false, tweets: nil) }
        }
    }
    
    class func userFromTweetJSON(tweetJSON: [String : AnyObject]) -> User
    {
        guard let name = tweetJSON["name"] as? String else { fatalError("Failed to parse name") }
        guard let profileImageURL = tweetJSON["profile_image_url"] as? String else { fatalError("Failed to parse profile image") }
        guard let location = tweetJSON["location"] as? String else { fatalError("Failed to parse location") }
        guard let screenName = tweetJSON["screen_name"] as? String else { fatalError() }
        
        return User(name: name, profileImageURL: profileImageURL, location: location, screenName: screenName)
        
    }
    
    class func JSONData() -> NSData
    {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else { fatalError("Missing tweet.json") }
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else { fatalError("Error creating NSData object.") }
        return tweetJSONData
    }
}