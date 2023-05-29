//
//  FeedVM.swift
//  TweetMD
//
//  Created by Kimberly Hsiao on 1/17/19.
//  Copyright © 2019 Doximity. All rights reserved.
//

import Foundation

protocol FeedVMContract {
    var medicalTweets: [Tweet] { get set }
    
    func setMedicalTweetsDidChangeClosure(callback: @escaping () -> Void) -> Void
}

class FeedVM: FeedVMContract {
    
    // MARK: Properties
    
    public var medicalTweets: [Tweet] = [] {
        didSet {
            self.medicalTweetsDidChange?()
        }
    }
    
    private var medicalTweetsDidChange: (() -> Void)?
    
    func setMedicalTweetsDidChangeClosure(callback: @escaping () -> Void) {
        self.medicalTweetsDidChange = callback
    }
    
    // MARK: Init
    
    init(webProvider: WebProviderContract) {
        webProvider.fetchMedicalTweets { result in
            switch result {
            case .failure(_):
                print("An error occured while fetching top medical tweets.")
            case .success(let tweets):
                self.medicalTweets = tweets
            }
        }
    }
    
}
