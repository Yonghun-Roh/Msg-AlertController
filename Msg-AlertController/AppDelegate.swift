//
//  AppDelegate.swift
//  Msg-AlertController
//
//  Created by Yonghun Roh on 2022/09/13.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        if #available(iOS 11.0, *) {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 사용자 동의 여부 창을 실행
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
            notiCenter.delegate = self
        } else {
            
        }
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 10.0, *) {//UserNotification 프레임워크를 이용한 로컬 알림 (iOS 10 이상)}
            // 알림 동의 여부를 확인
            UNUserNotificationCenter.current().getNotificationSettings { settings in if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                
                let nContent = UNMutableNotificationContent()
                nContent.badge = 1
                nContent.title = "로컬 알림 메시지"
                nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요!!"
                nContent.body = "여기에 본 내용을 적습니다.nContent.body"
                nContent.sound = UNNotificationSound.default
                nContent.userInfo = ["name": "홍길동"]
                
                // 알림 발송 조건 객체
                // 알림 발송 시간을 설정. 여기서는 5초 후에 자동 발송되도록 설정.
                // UserNotification에서 제공하는 객체는 두개. 하나는 UNTimeIntervalNotificationTrigger으로써 시간과 반복 여부를 설정. 입력값의 단위는 "초" 단위. 해당 예제는 5초 후에 알림 메시지를 발송하되 반복하지 말아라.
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // 알림 요청 객체
                let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                
                //노티피케이션 센터에 추가
                UNUserNotificationCenter.current().add(request)
            } else {
                print("사용자가 동의하지 않음!")
            }
            }
        } else { // UILocalNotification 객체를 이요한 로컬 알림 (ios9 이하)
            
        }
        
    }


}

@available(iOS 10.0, *)
func userNotificationCenter(_ center:UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    if notification.request.identifier == "wakeup" {
        let userInfo = notification.request.content.userInfo
        print(userInfo["name"]!)
        
    }
    // 알림 배너 띄워주기
    completionHandler([.banner, .badge, .sound])
}
 // 사용자가 알림 메시지를 클릭했을 경우

@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) { if response.notification.request.identifier == "wakeup" {
    let userInfo = response.notification.request.content.userInfo
    print(userInfo["name"]!)
}
    completionHandler()
}
