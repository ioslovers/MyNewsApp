//
//  MyNewsAppTests.swift
//  MyNewsAppTests
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import XCTest
@testable import MyNewsApp

class MyNewsAppTests: XCTestCase {
    
    var newsList: NewsData?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "MyNews", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        newsList = try? decoder.decode(NewsData.self, from: data)
    }

    override func tearDown() {
        newsList = nil
    }
    

    func testProductionServiceRunning() {
        // Put the code you want to measure the time of here.
        setUp()
        let expectation = self.expectation(description: "Get news service is failed and we don't receive correct response")
        Networking.fetchNews { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            default:
                XCTFail("Expected get news service response with error json")
            }
        }
        self.waitForExpectations(timeout: 6.0)
    }
    
    func testLatestNewsOnTop() {
        let expectation = self.expectation(description: "Looks like, latest news is not on the top")
        Networking.fetchNews { result in
            switch result {
            case .success(let data):
                var assests = data.assets
                assests.sort(by: { $0.timeStamp > $1.timeStamp})
                let firstDate = assests[0].timeStamp
                let secondDate = assests[1].timeStamp
                XCTAssertTrue(firstDate > secondDate)
                expectation.fulfill()
            default:
                XCTFail("Expected get news service response with error json")
            }
        }
        self.waitForExpectations(timeout: 6.0)
    }
    
    func testCompareThumbnailSize() {
        let expectation = self.expectation(description: "Looks like, latest news is not on the top")
        Networking.fetchNews { result in
            switch result {
            case .success(let data):
                var images = data.assets[0].relatedImages
                images.sort(by: { ($0.width + $0.height) < ($1.width + $1.height) })
                let firstImage = images[0]
                let secondImage = images[1]
                XCTAssertTrue((firstImage.width + firstImage.height) < (secondImage.width + secondImage.height))
                expectation.fulfill()
            default:
                XCTFail("Expected get news service response with error json")
            }
        }
        self.waitForExpectations(timeout: 6.0)
    }
    
    func testServiceError() {
        let expectation = self.expectation(description: "Looks like, latest news is not on the top")
        Networking.fetchNews(shouldFail: true) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            default:
                XCTFail("Expected get news service response with error json")

            }
        }
        self.waitForExpectations(timeout: 6.0)
    }
    
    func testDisplayName() {
        XCTAssertEqual(newsList?.displayName, "AFR iPad Editor's Choice")
    }
    
    func testNewsLink() {
        XCTAssertNotNil(newsList?.assets.first?.url)
    }
    
    func testThumbnailArray() {
        guard let releatedImage = newsList?.assets.first?.relatedImages else { return }
        XCTAssert(!releatedImage.isEmpty)
    }
    
}
