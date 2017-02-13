//
//  AppDelegate.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/22.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 设置窗口
//        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        self.window.backgroundColor = [UIColor whiteColor];
//        [self.window makeKeyAndVisible];
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        self.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        
        //UINavigationBar.appearance().setBackgroundImage(UIImage.imageWithColor(color: UIColor.orange), for: .default)
        
//        if let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
//            tabBarVC.tgg_presentAlertView(withMainTitle: "第一次打开app", actionTitle: "好的")
//        }
//        
//        
        
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
        AMAVersionManager.defaultManager.checkVersionUpdateAutomatically()
        
//        if let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
//            tabBarVC.tgg_presentAlertView(withMainTitle: "第一次打开app", actionTitle: "好的")
//        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

