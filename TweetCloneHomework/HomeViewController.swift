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
//            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpTableView()
    {
        self.tableView.dataSource = self
    }
    func update()
    {
        TweetJSONParser.tweetJSONFrom(TweetJSONParser.JSONData()) { (success, tweets) -> () in
            if success {
                if let tweets = tweets {
                    self.datasource = tweets
                }
            }
        }
        
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


