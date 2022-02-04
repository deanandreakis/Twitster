//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Born4Film on 10/13/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var createdOnLabel: UILabel!
    
    var liked:Bool = false
    var tweetId:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {self.setRetweet(true)}, failure: {(error) in print("Could not retweet! \(error)")})
    }
    
    @IBAction func likeTweet(_ sender: Any) {
        let toLike = !liked
        if (toLike) {
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success: {self.setLike(true)}, failure: {(error) in print("Could not like! \(error)")})
        } else {
            TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {self.setLike(false)}, failure: {(error) in print("Could not unlike! \(error)")})
        }
        
    }
    
    func setLike(_ isLiked:Bool){
        liked = isLiked
        if (liked) {
            likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet(_ isRetweeted:Bool){
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
}
