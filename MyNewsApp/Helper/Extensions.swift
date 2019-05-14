//
//  Extensions.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 12/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension
extension UIImageView {
    
    /// This loadThumbnail function is used to download thumbnail image using urlString
    /// This method also using cache of loaded thumbnail using urlString as a key of cached thumbnail.
    func loadThumbnail(urlSting: String) {
        guard let url = URL(string: urlSting) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        Networking.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                self.image = UIImage(named: "noImage")
            }
        }
    }
}

// MARK: - Date extension
extension Date {
    
    /// formattedDateString function is to format date in Australia/Sydney time zone
    /// and it return as a string
    func formattedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_AU")
        dateFormatter.timeZone = TimeZone(abbreviation: "Australia/Sydney")
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: self)
    }
}
