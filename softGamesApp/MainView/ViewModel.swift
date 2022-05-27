//
//  viewModel.swift
//  softGamesApp
//
//  Created by Ahmed Mohiy on 27/05/2022.
//
import Foundation
import WebKit

class ViewModel {
    
    let webViewHandler: WKWebViewHandler
    var webView: WKWebView?
    
    init (webViewHandler: WKWebViewHandler) {
        self.webViewHandler = webViewHandler
    }
    
    func handleName(parameters: [URLQueryItem]) {
        let firstName = parameters.first(where: {$0.name == Self.parametersName.first.rawValue})?.value ?? ""
        let secondName = parameters.first(where: {$0.name == Self.parametersName.second.rawValue})?.value ?? ""
        
        webViewHandler.sendName(webKit: webView,name: "\(firstName) \(secondName)")
    }
    
    func calculateAge(date: String) -> String {
        let calender = Calendar.current
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        if let birthDate = dateFormater.date(from: date) {
            let age = calender.dateComponents([.year], from: birthDate, to: Date())
            let ageYear = age.year
            return "\(ageYear ?? 0) years old"
        }
        return ""
    }
    
    func handleDate(date: String) {
        let age = calculateAge(date: date)
        if  age.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                self.webViewHandler.sendDate(webKit: self.webView,age: age)
            }
        }
       
    }
    
    func handleNotificationWith(title: String, body: String) {
        NotificationsHandler.shared.registerNotificatioln(title: title, body: body)
        UIControl().sendAction(#selector(NSXPCConnection.suspend),
                               to: UIApplication.shared, for: nil)
    }
    
    enum parametersName: String {
        case first = "first"
        case second = "second"
    }
    
    
    enum messageHandlerName: String {
        case getAge = "getAgeMessageHandler"
        case notifiyMe = "sendNotificationHandler"
    }
    
    enum getAgeAttributes: String {
        case date = "date"
    }
    
    enum notifyMeAttributes: String {
        case title = "title"
        case body = "body"
    }
}
