//
//  Author.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import Foundation

struct Author: Codable {
    let email: String?
    let name: String?
    let relatedAssets: [RelatedAsset]?
    let relatedImages: [RelatedImage]?
    let title: String?
}
