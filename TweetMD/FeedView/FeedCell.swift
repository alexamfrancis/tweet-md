//
//  FeedCell.swift
//  TweetMD
//
//  Created by Kimberly Hsiao on 1/22/19.
//  Copyright © 2019 Doximity. All rights reserved.
//

import Foundation
import UIKit

class FeedCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return "FeedCell"
    }
    static let cornerRadius: CGFloat = 5.0
    
    @IBOutlet private var thumbnailImage: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var handleLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    @IBOutlet private var timeElapsedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbnailImage.layer.cornerRadius = FeedCell.cornerRadius
        self.thumbnailImage.clipsToBounds = true
    }
    
    func configure(with tweet: Tweet) {
        self.nameLabel.text = tweet.author.name
        self.handleLabel.text = tweet.author.handle
        self.contentLabel.attributedText = tweet.text.getAttributedHandleString()
        self.timeElapsedLabel.text = Date.timeElapsedString(since: tweet.createdAt)
        self.contentView.backgroundColor = tweet.isFavorited ? .yellow : .white
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            if let profileImageUrl = tweet.author.profileImageUrl,
                let imageData = try? Data(contentsOf: profileImageUrl) {
                DispatchQueue.main.async {
                    self.thumbnailImage.image = UIImage(data: imageData)
                }
            } else {
                DispatchQueue.main.async {
                    self.thumbnailImage.image = nil
                }
            }
        }
    }
    
}
