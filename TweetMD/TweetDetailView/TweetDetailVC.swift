//
//  TweetDetailVC.swift
//  TweetMD
//
//  Created by Kimberly Hsiao on 1/24/19.
//  Copyright © 2019 Doximity. All rights reserved.
//

import Foundation
import UIKit

class TweetDetailVC: UIViewController {
    
    static let cornerRadius: CGFloat = 5.0

    // MARK: Properties
    private var viewModel: TweetDetailVMContract
    
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var handleLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    @IBOutlet private var favoriteButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
    
    @IBAction func tappedFavoriteButton(_ sender: UIButton) {
        self.viewModel.isFavorited = !self.viewModel.isFavorited
        self.updateFavoriteButton()
    }
    
    // MARK: Init
    init(viewModel: TweetDetailVMContract) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.viewModel.authorName
        self.handleLabel.text = self.viewModel.authorHandle
        self.contentLabel.attributedText = self.viewModel.content.getAttributedHandleString()
        self.dateLabel.text = self.viewModel.dateString
        self.thumbnailImageView.image = self.viewModel.authorProfilePhoto
        self.thumbnailImageView.layer.cornerRadius = TweetDetailVC.cornerRadius
        self.updateFavoriteButton()
    }
    
    // MARK: - Private helper functions
    private func updateFavoriteButton() {
        if self.viewModel.isFavorited {
            self.favoriteButton.backgroundColor = .darkGray
            self.favoriteButton.setTitle("Remove from Favorites", for: .normal)
        } else {
            self.favoriteButton.backgroundColor = .actionBlue
            self.favoriteButton.setTitle("Add to Favorites", for: .normal)
        }
    }
    
}
