//
//  AMAVersionInteractor.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/31.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class AMAVersionInteractor: NSObject {
    
    static func showForcedUpdateView(selectedBlock: ((UInt) -> Void)?) {
        if let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
            tabBarVC.tgg_presentAlertView(withMainTitle: "发现新版本(V2.0)", textLeftMessage: "更新内容\n1.ahhaha\n2.oooooo\n", actionTitle: "立即更新", successBlock: selectedBlock)
        }
    }
    
    static func showOptionalUpdateView(selectedBlock: ((UInt) -> Void)?) {
        if let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
            tabBarVC.tgg_presentAlertView(withMainTitle: "可选更新", textLeftMessage: "更新内容\n1.ahhaha\n2.oooooo\n", firstAction: "稍后再说", secondAction: "立即更新", successBlock: selectedBlock)
        }
    }
    
    static func showLatestUpdateView(selectedBlock:((UInt) -> Void)?) {
        if let tabBarVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
            tabBarVC.tgg_presentAlertView(withMainTitle: "已更新到最新版本", actionTitle: "确定", successBlock: selectedBlock)
        }
    }
    
}
