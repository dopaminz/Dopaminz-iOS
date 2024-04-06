//
//  AppDelegate.swift
//  Dopaminz
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import UIKit


class AppDelegate: UIViewController, UIApplicationDelegate{
    
    //MARK: - 앱이 시작 되었을때
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.banner, .sound, .list])
  }
}

