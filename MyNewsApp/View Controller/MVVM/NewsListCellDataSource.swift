//
//  NewsListCellDataSource.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

final class NewsListCellDataSource {
    private let asset: Asset?
    
    //Dependencies injection
    init(asset: Asset) {
        self.asset = asset
    }
}

extension NewsListCellDataSource: NewsListCellData {
    
    /// News cell value for voice over accessibility text and cell identifier for UI Automation
    var cellValue: UIElementValue<String> {
        guard let asset = asset else {
            return UIElementValue(rawValue: "")
        }
        let footerString = String(format: "%@ \n %@", arguments: [asset.byLine, asset.timeStamp.formattedDateString()])
        let cellAccessebilityValue = String(format: NSLocalizedString("localiseCellAccessibilityText", comment: ""), arguments: [asset.headline, asset.theAbstract, footerString])
        return UIElementValue(rawValue: "",
                              accessibilityValue: cellAccessebilityValue,
                              accessibilityIdentifier: "NewsCell_\(asset.id)")
    }
    
    /// News cell title and for voice over accessibility text and cell identifier for UI Automation
    var title: UIElementValue<String> {
        guard let asset = asset else {
            return UIElementValue(rawValue: "")
        }
        return UIElementValue(rawValue: asset.headline,
                              accessibilityValue: asset.headline,
                              accessibilityIdentifier: ConstantIdentifiers.cellTitleIdentifier.rawValue)
    }
    
    /// News cell body and voice over accessibility text and cell identifier for UI Automation
    var body: UIElementValue<String> {
        guard let asset = asset else {
            return UIElementValue(rawValue: "")
        }
        return UIElementValue(rawValue: asset.theAbstract,
                              accessibilityValue: asset.theAbstract,
                              accessibilityIdentifier: ConstantIdentifiers.cellBodyIdentifier.rawValue)
    }
    
    /// News cell footer and voice over accessibility text and cell identifier for UI Automation
    var footer: UIElementValue<String> {
        guard let asset = asset else {
            return UIElementValue(rawValue: "")
        }
        let footerString = String(format: "%@ \n %@", arguments: [asset.byLine, asset.timeStamp.formattedDateString()])
        return UIElementValue(rawValue: footerString,
                              accessibilityValue: footerString,
                              accessibilityIdentifier: ConstantIdentifiers.cellFooterTitleIdentifier.rawValue)
    }
    
    /// News cell footer and voice over accessibility text and cell identifier for UI Automation
    var icon: UIElementValue<String> {
        var images = asset?.relatedImages
        
        /// Filter smallest thumbnail image from array of relatedImages
        images?.sort(by: { ($0.width + $0.height) < ($1.width + $1.height) })
        
        guard let smallestImage = images?.first else {
            return UIElementValue(rawValue: "")
        }
        return UIElementValue(rawValue: smallestImage.url,
                              accessibilityValue: NSLocalizedString("localiseNewsThumnailImage", comment: ""),
                              accessibilityIdentifier: ConstantIdentifiers.cellIconIdentifier.rawValue)
    }
}
