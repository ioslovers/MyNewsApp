//
//  RelatedAsset.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import Foundation

struct RelatedAsset: Codable {
    let assetType: String?
    let authors: [Author]?
    let categories: [Category]?
    let headline: String?
    let id: Int?
    let lastModified: Int?
    let sponsored: Bool
    let timeStamp: Int?
    let url: String?
}
