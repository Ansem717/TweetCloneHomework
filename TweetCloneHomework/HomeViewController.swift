//
//  ViewController.swift
//  TweetCloneHomework
//
//  Created by Allen Hurst on 2/8/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.accountAlert()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpTableView()
    {
        self.tableView.dataSource = self
    }
    
    func accountAlert()
    {
        API.shared.login({ (accounts) -> () in
            if let accounts = accounts {
                if accounts.count > 1 {
                    
                    let alertControl = UIAlertController(title: "The decision is yours", message: "Choose an account", preferredStyle: .Alert)
                    for account in accounts {
                        
                        let never = UIAlertAction(title: "\(account.username)", style: .Default) { (action) in
                            API.shared.currAcc = account
                            self.update()
                        }
                        alertControl.addAction(never)
                    }
                    
                    self.presentViewController(alertControl, animated: true){
                        //...
                    }
                    
                    
                } else {
                    API.shared.currAcc = accounts.first
                    self.update()
                }
                
                
            }
        })
        
        
        
        
    }
    func update()
    {
        API.shared.GETTweets { (tweets) -> () in
            if let tweets = tweets {
                self.datasource = tweets
                
                
                API.shared.GETOAuthUser{ (user) -> () in
                    if let user = user {
                        print(user.name)
                        print(user.profileImageURL)
                        print(user.location)
                    }
                }
            }
        }
        
    }
    
    @IBAction func userButton(sender: UIButton) {
        accountAlert()
    }
}

extension HomeViewController
{
    func configureCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell
    {
        let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        let tweet = self.datasource[indexPath.row]
        tweetCell.textLabel?.text = tweet.text
        
        return tweetCell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.datasource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        return self.configureCellForIndexPath(indexPath)
    }
}


