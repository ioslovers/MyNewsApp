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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testServiceRunning() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
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
    }
    
    func testLatestNewsOnTop() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
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
    }
    
    func testCompareThumbnailSize() {
        self.measure {
            // Put the code you want to measure the time of here.
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
    }
}
