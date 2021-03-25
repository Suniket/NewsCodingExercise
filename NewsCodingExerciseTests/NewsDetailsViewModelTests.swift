//
//  NewsDetailsViewModelTests.swift
//  NewsCodingExerciseTests
//
//  Created by Suniket Wagh on 25/3/21.
//

import XCTest
import Foundation
@testable import NewsCodingExercise

class NewsDetailsViewModelTests: XCTestCase {
    
    var testObject: NewsDetailsViewModel!
        
    override func setUp() {
        testObject = NewsDetailsViewModel()
    }

    func testPubDate() {
        testObject.item = Item(title: nil, pubDate: "2021-03-24 11:12:07", thumbnail: nil, description: nil, content: nil, enclosure: nil)

        XCTAssertEqual(testObject.pubDate, "March 24, 2021 at 11:12 AM")
    }
}
