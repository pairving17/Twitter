//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Philip Irivng  on 2/12/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var UserNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var liked: Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    

    @IBAction func likeTweet(_ sender: Any) {
        let tobeLiked = !liked
        if (tobeLiked){
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId , success: {self.setLiked(true)}, failure: { (error) in
                print("Liked did not succeed: \(error)")
            })
        }
        
        else {
            TwitterAPICaller.client?.unLikeTweet(tweetId: tweetId , success: {self.setLiked(false)}, failure: { (error) in
                print("UNLiked did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error is retweeting: \(error.localizedDescription)")
        })
        
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if(retweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
            
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
            
        }
    }
    
    func setLiked(_ isLiked: Bool){
        liked = isLiked
        if (liked){
            likeButton.setImage(UIImage (named: "favor-icon"), for:  UIControl.State.normal)
        } else { likeButton.setImage(UIImage(named: "favor-icon-1"), for: UIControl.State.normal)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
