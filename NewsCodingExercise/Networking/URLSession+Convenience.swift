//
//  URLSession+Convenience.swift
//  NewsCodingExercise
//
//  Created by Suniket Wagh on 24/3/21.
//

import Foundation

/// URLSession protocol
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    func dataTask(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}


extension URLSessionDataTask: URLSessionDataTaskProtocol {}
