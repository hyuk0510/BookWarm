//
//  AppDelegate.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(schemaVersion: 4) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 { } // memo -> selfMemo Column 이름 변경

            if oldSchemaVersion < 2 { } // selfMemo -> memo Column 이름 변경 메모 다 날라갔네
            
            if oldSchemaVersion < 3 {
                migration.renameProperty(onType: BookTable.className(), from: "memo", to: "selfMemo")
            } // memo -> selfMemo Column 이름 변경
            
            if oldSchemaVersion < 4 {
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["titleAndMemo"] = "책 제목: \(old["title"]), 메모: \(old["selfMemo"])"
                } // titleAndMemo 추가, 기존 title과 memo 를 합쳐서 값 생성
            }
        }
        
        Realm.Configuration.defaultConfiguration = config

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


}

