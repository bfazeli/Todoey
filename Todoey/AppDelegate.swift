//
//  AppDelegate.swift
//  Todoey
//
//  Created by Bijan Fazeli on 6/5/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do {
            try _ = Realm()
        } catch {
            print("Couldn't load Realm")
        }
        
        
        return true
    }

}

