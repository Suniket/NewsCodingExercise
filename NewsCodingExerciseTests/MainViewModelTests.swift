//
//  MainViewModelTests.swift
//  NewsCodingExerciseTests
//
//  Created by Suniket Wagh on 24/3/21.
//

import XCTest
import Foundation
@testable import NewsCodingExercise

class MainViewModelTests: XCTestCase {
    
    var testObject: MainViewModel!
    
    var delegate: MockMainViewModelDelegate!
    
    override func setUp() {
        testObject = MainViewModel()
        
        delegate = MockMainViewModelDelegate()
        testObject.delegate = delegate
    }
    
    override func tearDown() {}

    func testRefresh() {
        
        //Given
        testObject.networkManager = NetworkManager(session: MockURLSession())
        
        //When
        testObject.reloadData()
        
        //Then
        XCTAssertTrue(delegate.loadingStateDidChangeCount == 2)
        XCTAssertTrue(testObject.totalItems.count == 0)
        XCTAssertTrue(testObject.errorAlertViewModel != nil)
        XCTAssertTrue(testObject.errorAlertViewModel == AlertViewModel(actionModels: [AlertViewModel.ActionModel(title: "OK", style: .cancel, handler: nil)],
                                                                       title: "Error",
                                                                       message: "No JSON data available.",
                                                                       prefferedStyle: .alert))
    }
}

class MockMainViewModelDelegate: MainViewModelDelegate {
    
    var loadingStateDidChangeCount = 0

    func viewModel(_ viewModel: MainViewModel, loadingStateDidChange isLoading: Bool) {
        loadingStateDidChangeCount += 1
    }
}
