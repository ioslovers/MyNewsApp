//
//  RelatedImage.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import Foundation

struct RelatedImage: Codable {
    let assetType: String?
    let authors: [Author]?
    let brands: [Brand]?
    let categories: [Category]?
    let descriptionField: String?
    let height: Int
    let id: Int?
    let lastModified: Int?
    let photographer: String?
    let sponsored: Bool
    let timeStamp: Int?
    let type: String?
    let url: String
    let width: Int
}

struct Brand: Codable {}

