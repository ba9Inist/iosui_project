//
//  PushManager.swift
//  Navigation
//
//  Created by Егор Голубев on 24.07.2025.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    
    static let shared = LocalNotificationsService()
    
    private init() {}
    
    func checkAccess() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert]) { granted, error in
            if granted {
                self.setTaskToSendPush()
            } else {
                print("Доступ к уведомлениям запрещён")
            }
        }
    }
    
    private func setTaskToSendPush() {
        let content = UNMutableNotificationContent()
        content.title = "Обновление"
        content.body = "Посмотрите последнее обновление"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyUpdates", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка планирования уведомления:", error.localizedDescription)
            } else {
                print("Уведомление запланировано успешно!")
            }
        }
    }
}
