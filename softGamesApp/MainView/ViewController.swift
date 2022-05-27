//
//  ViewController.swift
//  softGamesApp
//
//  Created by Ahmed Mohiy on 27/05/2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView?
    
    var viewModel = ViewModel(webViewHandler: WKWebViewHandler())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController.add(self, name: ViewModel.messageHandlerName.getAge.rawValue)
        configuration.userContentController.add(self, name: ViewModel.messageHandlerName.notifiyMe.rawValue)
        let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        webView = WKWebView(frame: rect, configuration: configuration)
        webView?.navigationDelegate = self
        viewModel.webView = webView
        self.view.addSubview(webView!)
        
        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            let request = URLRequest(url: url)
            webView?.load(request)
        } else {
            print("ERROR: Failed to load index.html file")
        }
    }


}

extension ViewController: WKScriptMessageHandler, WKNavigationDelegate {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == ViewModel.messageHandlerName.getAge.rawValue {
            guard let  dic = message.body as? [String:Any],
                  let date = dic[ViewModel.getAgeAttributes.date.rawValue] as? String else {
                      return
                  }

            viewModel.handleDate(date: date)

        } else if message.name == ViewModel.messageHandlerName.notifiyMe.rawValue {
            guard let  dic = message.body as? [String:Any],
                  let title = dic[ViewModel.notifyMeAttributes.title.rawValue] as? String,
                  let body = dic[ViewModel.notifyMeAttributes.body.rawValue] as? String else {
                      return
                  }
            
            viewModel.handleNotificationWith(title: title, body: body)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
            if let urlString = url?.absoluteString,
               let queryItems = URLComponents(string:urlString)?.queryItems {
                viewModel.handleName(parameters: queryItems)
            }
            decisionHandler(.allow)
    }
    
}

