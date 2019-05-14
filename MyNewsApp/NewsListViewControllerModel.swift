//
//  NewsListViewControllerModel.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 14/05/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import Foundation

class NewsListViewControllerModel {
    
    private let newsData: [Asset]?
    
    //Dependency Injection
    init(newsData: [Asset]) {
        self.newsData = newsData
    }
    
    func sortedNews() -> [Asset]? {
        guard var sortedNews = self.newsData else { return nil}
        sortedNews.sort(by: { $0.timeStamp > $1.timeStamp})
        return sortedNews
    }
}
