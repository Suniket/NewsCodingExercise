//
//  MockURLSession.swift
//  NewsCodingExerciseTests
//
//  Created by Suniket Wagh on 24/3/21.
//

import Foundation
@testable import NewsCodingExercise

//MARK: MOCK
class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    func successHttpURLResponse(url: URL) -> URLResponse {
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        
        completionHandler(nextData, successHttpURLResponse(url: url), nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
