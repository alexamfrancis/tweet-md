//
//  WebProvider.swift
//  TweetMD
//
//  Created by Kimberly Hsiao on 1/22/19.
//  Copyright © 2019 Doximity. All rights reserved.
//

import Foundation
import Alamofire

enum FetchError: Error {
    case invalidUrl
    case responseFailure
    case serializationError
}

enum Constants {
    static let searchTweetsUrlString = "https://api.twitter.com/1.1/search/tweets.json"
    static let token = "AAAAAAAAAAAAAAAAAAAAANLi3wAAAAAAIugIfddmQcEt4aetIH%2BE42nNk4E%3Dh5ZxkNhQP9cAigpbfm87oK6BTzkRj9OlZo6BR9GQcGdgWbbgfP"
}

protocol WebProviderContract {
    func fetchMedicalTweets(completion: @escaping (Swift.Result<[Tweet], FetchError>) -> Void)
}

class WebProvider: WebProviderContract {
    func fetchMedicalTweets(completion: @escaping (Swift.Result<[Tweet], FetchError>) -> Void) {
        guard let url = URL(string: Constants.searchTweetsUrlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        Alamofire.request(url,
                          parameters: ["q": "medicine"],
                          headers: ["Authorization": "Bearer \(Constants.token)"])
            .validate()
            .responseJSON { responseData in
                guard let tweetsData = responseData.data, responseData.result.isSuccess else {
                    completion(.failure(.responseFailure))
                    return
                }
                
                guard
                    let tweetsContainer = try? JSONDecoder().decode(TweetsContainer.self, from: tweetsData)
                    else {
                        completion(.failure(.serializationError))
                        return
                }
                
                completion(.success(tweetsContainer.tweets))
        }
    }
}
