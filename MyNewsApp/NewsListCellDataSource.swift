//
//  NewsListCellDataSource.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

final class NewsListCellDataSource {
    let asset: Asset?
    
    //Dependencies injection
    init(asset: Asset) {
        self.asset = asset
    }
}

extension NewsListCellDataSource: NewsListCellData {
    var title: UIElementValue<String> {
        guard let asset = asset else {
            return UIElementValue(rawValue: "")
        }
        return UIElementValue(rawValue: asset.headline,
                              accessibilityValue: asset.headline,
                              accessibilityIdentifier: asset.headline)
    }
    
    var body: UIElementValue<String> {
        guard let asset = asset else {
            return UIElementValue(rawValue: "")
        }
        return UIElementValue(rawValue: asset.theAbstract,
                              accessibilityValue: asset.theAbstract,
                              accessibilityIdentifier: asset.theAbstract)
    }
    
    var footer: UIElementValue<String> {
        guard let asset = asset else {
            return UIElementValue(rawValue: "")
        }
        return UIElementValue(rawValue: "\(asset.byLine) \n \(asset.timeStamp.formattedDateString())",
                              accessibilityValue: asset.byLine,
                              accessibilityIdentifier: asset.byLine)
    }
    
    var icon: UIElementValue<String> {
        guard var images = asset?.relatedImages else {
            return UIElementValue(rawValue: "")
        }
        images.sort(by: { ($0.width + $0.height) < ($1.width + $1.height) })
        guard let smallestImage = images.first else {
            return UIElementValue(rawValue: "")
        }
        return UIElementValue(rawValue: smallestImage.url,
                              accessibilityValue: "",
                              accessibilityIdentifier: "")
    }
}
