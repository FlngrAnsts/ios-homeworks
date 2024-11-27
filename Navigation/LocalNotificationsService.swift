//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Anastasiya on 19.11.2024.
//

import Foundation
import UserNotifications

class LocalNotificationsService: NSObject{
    
    func registeForLatestUpdatesIfPossible(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert]) { granted, error in
            guard granted else {
                print("Доступ к уведомлениям не предоставлен")
                return
            }
            self.scheduleDailyNotification()
        }
    }
    
    private func scheduleDailyNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Напоминание"
        content.body = "Посмотрите последние обновления"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "DailyUpdateNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
    

    
}
