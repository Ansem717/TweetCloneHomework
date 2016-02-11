//
//  SimpleCache.swift
//  TweetCloneHomework
//
//  Created by Andy Malik on 2/11/16.
//  Copyright © 2016 Allen Hurst. All rights reserved.
//

import UIKit

class SimpleCache
{
    static let shared = SimpleCache()
    private init() {}
    
    private var cache = [String : UIImage]()
    private let limit = 20
    
    func getImage(key: String) -> UIImage?
    {
        return self.cache[key]
    }
    
    func setImage(key: String, image: UIImage)
    {
        if self.cache.count >= limit {
            guard let key = Array(self.cache.keys).last else { return }
            self.cache[key] = nil
        }

        self.cache[key] = image
    }
}