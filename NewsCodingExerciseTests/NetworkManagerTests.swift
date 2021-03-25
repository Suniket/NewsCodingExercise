//
//  NetworkManagerTests.swift
//  NewsCodingExerciseTests
//
//  Created by Suniket Wagh on 24/3/21.
//

import XCTest
import Foundation
@testable import NewsCodingExercise

class NetworkManagerTests: XCTestCase {
    
    var testObject: NetworkManager!
    
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        testObject = NetworkManager(session: session)
    }
    
    override func tearDown() {}
    
    func testLoadData() {
        //Given
        let expectedData = "{}".data(using: .utf8)
        let dataTask = MockURLSessionDataTask()
        var actualData: NetworkResponse<NewsResponse>?

        //When
        session.nextDataTask = dataTask
        session.nextData = expectedData
        
        testObject.loadData(from: "https://mockurl", type: NewsResponse.self, withCompletion: { response in
            actualData = response
        })
        
        //Then
        XCTAssertNotNil(actualData)
        XCTAssert(dataTask.resumeWasCalled)
        
    }
    
}
