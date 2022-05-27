//
//  softGamesAppTests.swift
//  softGamesAppTests
//
//  Created by Ahmed Mohiy on 27/05/2022.
//

import XCTest
@testable import softGamesApp

class ViewModelTest: XCTestCase {

    var viewModel: ViewModel?
    var webViewHandle: MockWebViewHandler?
    override func setUp() {
        webViewHandle = MockWebViewHandler()
        viewModel = ViewModel(webViewHandler: webViewHandle!)
    }
    
    func testNameSynchronous() {
        let firstName = "Ahmed"
        let secondName = "Mohiy"
        let parameters:[URLQueryItem] = [URLQueryItem(name: ViewModel.parametersName.first.rawValue, value: firstName),
                                         URLQueryItem(name: ViewModel.parametersName.second.rawValue, value: secondName)]
        self.viewModel?.handleName(parameters: parameters)
        
        XCTAssertEqual(webViewHandle!.name, "\(firstName) \(secondName)")
        
    }
    
    func testAgeAsynchronous() {
        let date = "2010-12-11"
        let expectation = expectation(description: "testAgeAsynchronous expectation")
        webViewHandle?.expectacion = expectation
        self.viewModel?.handleDate(date: date)
        waitForExpectations(timeout: 6)
        let age = viewModel?.calculateAge(date: date)
        XCTAssertEqual(age, webViewHandle!.age)
    }

    override func tearDown() {
        webViewHandle = nil
        viewModel = nil
    }

}
