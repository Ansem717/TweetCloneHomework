//
//  api.swift
//  TweetCloneHomework
//
//  Created by Allen Hurst on 2/9/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import Foundation
import Accounts
import Social

class API
{
    static let shared = API()
    private init() {}
    
    var currAcc: ACAccount?
    
    
    func GETTweets(completion: (tweets: [Tweet]?) -> ())
    {
        
        if let _ = currAcc {
            self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
            return
        } else {
            print("Account is nil.")
        }
        
    }
    
    func GETUserTweets(username: String, completion: (tweets: [Tweet]?) -> ())
    {
        self.updateTimeline("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(username)", completion: completion)
    }
    
    func GETImage(urlString: String, completion: (image: UIImage) -> ())
    {
        NSOperationQueue().addOperationWithBlock { () -> Void in
            guard let url = NSURL(string: urlString) else {return}
            guard let data = NSData(contentsOfURL: url) else { return }
            guard let image = UIImage(data: data) else {return}
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(image: image)
            })
        }
    }
    
    private func updateTimeline(urlString: String, completion: (tweets: [Tweet]?) -> ())
    {
        let request = SLRequest(
            forServiceType: SLServiceTypeTwitter,
            requestMethod: .GET,
            URL: NSURL(string: urlString),
            parameters: nil)
        
        /// https://api.twitter.com/1.1/statuses/home_timeline.json//
        
        
        request.account = self.currAcc
        request.performRequestWithHandler { (data, response, error) -> Void in
            if let _ = error {
                print("Error: Slrequest tyoe .get could not be completed")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(tweets: nil) }; return
            }
            
            switch response.statusCode
            {
                
            case 200...299:
                
                TweetJSONParser.tweetJSONFrom(data, completion: { (sucess, tweets) -> () in
                    NSOperationQueue.mainQueue().addOperationWithBlock{ completion(tweets: tweets) }
                })
                
            case 300...399:
                print("Error: SLRequest type .GET returned status code \(response.statusCode)")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(tweets: nil) }
                
            case 400...499:
                print("Error: SLRequest type .GET returned status code \(response.statusCode)")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(tweets: nil) }
                
            case 500...599:
                print("Error: SLRequest type .GET returned status code \(response.statusCode)")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(tweets: nil) }
                
                
            default:
                print("Error: SLRequest type .GET returned status code \(response.statusCode)")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(tweets: nil) }
            }
        }
        
    }
    
    func login(completion: (account: [ACAccount]?) -> ())
    {
        let accountStore = ACAccountStore()
        
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
            if let _ = error {
                print("ERROR: Request access to accounts returned an error.")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(account: nil) }
                return
            }
            // MARK: Set Twitter account
            if granted {
                if let account = accountStore.accountsWithAccountType(accountType) as? [ACAccount] {
                    NSOperationQueue.mainQueue().addOperationWithBlock { completion(account: account) }
                    return
                }
                
                print("Error: no twitter accounts were found on this device")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(account: nil)}
                return
            }
            print("Error: this app requires access to twitter accounts")
            NSOperationQueue.mainQueue().addOperationWithBlock{ completion(account: nil)}
            return
        }
    }
    
    func GETOAuthUser(completion: (user: User?) -> ())
    {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: "HTTPS://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        request.account = self.currAcc
        
        request.performRequestWithHandler { ( data, response, error) -> Void in
            
            if let _ = error {
                print("ERROR: SLRequest type .GET  returned status code \(response.statusCode)")
                
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(user: nil) }; return
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject] {
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            completion(user: TweetJSONParser.userFromTweetJSON(userJSON))
                        })
                    }
                } catch _ {}
                
            case 300...399:
                print("Error[USER]: SLRequest type .GET returned status code \(response.statusCode)")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(user: nil) }
                
            case 400...499:
                print("Error[USER]: SLRequest type .GET returned status code \(response.statusCode)")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(user: nil) }
                
            case 500...599:
                print("Error[USER]: SLRequest type .GET returned status code \(response.statusCode)")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(user: nil) }
                
            default:
                print("Error[USER]: SLRequest type .GET returned status code \(response.statusCode)")
                NSOperationQueue.mainQueue().addOperationWithBlock{ completion(user: nil) }
                
                
            }
        }
    }
}