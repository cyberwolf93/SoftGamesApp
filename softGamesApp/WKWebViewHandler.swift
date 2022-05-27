//
//  WKWebViewHandler.swift
//  softGamesApp
//
//  Created by Ahmed Mohiy on 27/05/2022.
//

import Foundation
import WebKit

class WKWebViewHandler {
    
    func sendName(webKit: WKWebView?, name: String) {
        webKit?.evaluateJavaScript("writeName('\(name)')")
    }
    
    func sendDate(webKit: WKWebView?,age: String) {
        webKit?.evaluateJavaScript("writeAge('\(age)')")
    }
}
