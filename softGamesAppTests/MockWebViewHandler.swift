//
//  MockWebViewHandler.swift
//  softGamesAppTests
//
//  Created by Ahmed Mohiy on 27/05/2022.
//

import Foundation
import XCTest
import WebKit

@testable import softGamesApp

class MockWebViewHandler: WKWebViewHandler {
    
    var expectacion: XCTestExpectation?
    var name: String = ""
    var age: String = ""
    
    override func sendName(webKit: WKWebView?, name: String) {
        self.name = name
        expectacion?.fulfill()
    }
    
    override func sendDate(webKit: WKWebView?,age: String) {
        self.age  = age
        expectacion?.fulfill()
    }
}
