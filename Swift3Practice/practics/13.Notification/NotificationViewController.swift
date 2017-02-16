//
//  NotificationViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 17/2/14.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController, UNUserNotificationCenterDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        let register = UIBarButtonItem(title: "register", style: .plain, target: self, action: #selector(registerNotificaton))
        let schedual = UIBarButtonItem(title: "schedual", style: .plain, target: self, action: #selector(schedualNotification))
        navigationItem.rightBarButtonItems = [register, schedual]
        
        // 获取用户当前的通知设置
        UNUserNotificationCenter.current().getNotificationSettings { (notiSetting:UNNotificationSettings) in
            print(notiSetting)
        }
    }

    // 请求通知权限
    func registerNotificaton(){
        let nc = UNUserNotificationCenter.current()
        nc.requestAuthorization(options:[.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("ok")
            } else {
                print("no")
            }
        }
    }
    
    // 注册category,给通知使用
    func registerCategories() {
        let nc = UNUserNotificationCenter.current()
        nc.delegate = self;
        
        let action1 = UNNotificationAction(identifier: "action1", title: "action1", options: .foreground)
        let action2 = UNNotificationAction(identifier: "action2", title: "action2", options: .foreground)
        let category = UNNotificationCategory(identifier: "category1", actions: [action1, action2], intentIdentifiers: [])
        
        
        let action3 = UNNotificationAction(identifier: "action3", title: "action3", options: .foreground)
        let action4 = UNNotificationAction(identifier: "action4", title: "action4", options: .foreground)
        let category2 = UNNotificationCategory(identifier: "category2", actions: [action3, action4], intentIdentifiers: [])
        
        nc.setNotificationCategories([category,category2])
    }
    
    // 发送通知
    func schedualNotification(){
        
        registerCategories()

        let nc = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "title"
        content.body = "this is body"
        content.sound = UNNotificationSound.default()
        content.subtitle = "this is subtitle"
        // 添加附带品
        if let url = Bundle.main.url(forResource: "notificationTest", withExtension: "png") {
            if let image = try? UNNotificationAttachment(identifier: "image", url: url, options:nil){
                content.attachments = [image]
            }
        }
        content.categoryIdentifier = "category2"        // action操作
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        nc.add(request, withCompletionHandler: nil)
    }
    
    // 操作通知的回调
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    // app在前台时，通知的展示与否，不实现该方法的话默认不展示
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 展示
        completionHandler([.alert, .sound])
        // 不展示
        completionHandler([])
    }
}
