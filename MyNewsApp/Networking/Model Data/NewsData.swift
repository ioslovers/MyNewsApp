//
//  RootClass.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import Foundation

struct NewsData: Codable {
    let assets: [Asset]
    let assetType: String?
    let authors: [Author]?
    let categories: [Category]?
    let displayName: String?
    let id: Int?
    let lastModified: Int?
    let onTime: Int?
    let relatedAssets: [RelatedAsset]?
    let relatedImages: [RelatedImage]?
    let sponsored: Bool?
    let timeStamp: Int?
    let url: String?
}
