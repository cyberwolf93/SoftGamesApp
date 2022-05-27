//
//  NotificationsHandler.swift
//  softGamesApp
//
//  Created by Ahmed Mohiy on 27/05/2022.
//

import Foundation
import UserNotifications

class NotificationsHandler: NSObject {
    
    let userNotification = UNUserNotificationCenter.current()
    static let shared: NotificationsHandler = NotificationsHandler()
    
    private override init() {
        super.init()
        self.userNotification.delegate = self
    }
    
    func removeAll() {
        userNotification.removeAllPendingNotificationRequests()
    }
    
    func requestNotificationAuth() {
        let options = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        self.userNotification.requestAuthorization(options: options) { success, error in
            if let err = error {
                print("Notification request Authorization failed: \(err)")
            }
        }
    }
    
    func registerNotificatioln(title: String, body: String) {
        let notification = UNMutableNotificationContent()
        notification.title = title
        notification.body = body
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        let request = UNNotificationRequest(identifier: "identifier",
                                            content: notification,
                                            trigger: notificationTrigger)
        
        userNotification.add(request) { (error) in
            if let err = error {
                print("Notification register failed: \(err)")
            }
        }
        
    }
}

extension NotificationsHandler: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
