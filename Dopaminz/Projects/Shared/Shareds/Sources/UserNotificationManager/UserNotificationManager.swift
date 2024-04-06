//
//  UserNotificationManager.swift
//  Shareds
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import UserNotifications
import Service

public class UserNotificationManager {
    
    // MARK: - Properties
    
    static let shared = UserNotificationManager()
    
    
    // MARK: - Initializers
    
    private init() { }
    
    
    // MARK: - Public
    
    public func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, error in
            if let error {
                Log.custom(category: "Permission", "Fail to request notification permission")
                return
            }
            
            if isGranted {
                Log.custom(category: "Permission", "Success to get notification permission")
            } else {
                Log.custom(category: "Permission", "Success to get notification permission")
            }
        }
    }
    
    public func scheduleNotification(
        date: Date,
        title: String,
        body: String,
        identifier: String = UUID().uuidString
    ) {
        // 알림 내용 설정
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        // 알림이 트리거 될 시간 설정
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        Log.custom(category: "UserNotification", "Notification scheduled on \(date)")
        
        // 트리거 설정
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 알림 요청 생성
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // 알림 센터에 요청 추가
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                Log.error("Fail to register user notification")
            }
        }
    }
}
