//
//  Asset.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import Foundation

struct Asset: Codable {
    let acceptComments: Bool
    let assetType: String?
    let authors: [Author]?
    let byLine: String
    let categories: [Category]?
    let companies: [Company]?
    let headline: String
    let id: Int?
    let indexHeadline: String?
    let lastModified: Int?
    let legalStatus: String?
    let numberOfComments: Int?
    let onTime: Int?
    let overrides: Override?
    let relatedAssets: [RelatedAsset]?
    let relatedImages: [RelatedImage]
    let signPost: String?
    let sources: [Source]?
    let sponsored: Bool
    let tabletHeadline: String?
    let theAbstract: String
    let timeStamp: Date
    let url: String?
}

struct Company: Codable {}
