//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Born4Film on 10/13/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var timeline = [NSDictionary]()
    var numberOfTweets: Int!
    
    let refreshment = UIRefreshControl()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        refreshment.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refreshment
    }
    
    @objc func loadTweets() {
        
        numberOfTweets = 25
        let tweetsUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": numberOfTweets]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: tweetsUrl, parameters: params, success: { (tweets: [NSDictionary]) in
            
            self.timeline.removeAll()
            
            for tweet in tweets {
                self.timeline.append(tweet)
            }
            
            self.tableView.reloadData()
            self.refreshment.endRefreshing()
            
        }, failure: { Error in
            print("No tweets retrieved.")
        })
        
    }
    
    func loadMoreTweets() {
        
        numberOfTweets = numberOfTweets + 25
        let tweetsUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: tweetsUrl, parameters: params, success: { (tweets: [NSDictionary]) in
            
            self.timeline.removeAll()
            
            for tweet in tweets {
                self.timeline.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { Error in
            print("No tweets retrieved.")
        })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == timeline.count {
            loadMoreTweets()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        let user = timeline[indexPath.row]["user"] as! NSDictionary
        
        cell.userLabel.text = user["name"] as! String
        cell.tweetLabel.text = timeline[indexPath.row]["text"] as! String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.userImage.image = UIImage(data: imageData)
        }
        
        return cell
    }

    @IBAction func onSignOut(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "signedIn")
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timeline.count
    }

   

}
