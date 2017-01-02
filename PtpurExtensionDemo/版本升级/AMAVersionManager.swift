//
//  AMAVersionManager.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/31.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit


let manager = AMAVersionManager()
class AMAVersionManager: NSObject {
    
    class var defaultManager: AMAVersionManager {
        return manager
    }
    
    var service: AMAVersionService{
        return AMAVersionService()
    }
    
    
    func checkVersionUpdateAutomatically() {
        if AMAVersionLocalRecordAgent.isAppFirstBecomeActiveToday() {
            service.fetchLatestVersion { (updateType) in
                switch updateType {
                case .forced:
                    AMAVersionInteractor.showForcedUpdateView(selectedBlock: { (selectedIndex) in
                        if selectedIndex == 0 {
                            AMAVersionLocalRecordAgent.clearRecord()
                            self.appUpdate()
                        }
                    })
                case .optional:
                    if AMAVersionLocalRecordAgent.isShowUpdateView() {
                        AMAVersionInteractor.showOptionalUpdateView(selectedBlock: { (selectedIndex) in
                            if selectedIndex == 0 {
                                AMAVersionLocalRecordAgent.writeTodayToLocal()
                            } else if selectedIndex == 1 {
                                AMAVersionLocalRecordAgent.clearRecord()
                                self.appUpdate()
                            }
                        })
                    }
                case .latest:
                    debugPrint("The App is latest version!")
                }
            }
        }
    }
    
    
    func checkVersionUpdateManually(at viewController:UIViewController?) {
        // 展示菊花转动
        // 关闭转动
        service.fetchLatestVersion { (updateType) in
            switch updateType {
            case .forced:
                    AMAVersionInteractor.showForcedUpdateView(selectedBlock: { (selectedIndex) in
                        if selectedIndex == 0 {
                            AMAVersionLocalRecordAgent.clearRecord()
                            self.appUpdate()
                        }
                    })
            case .optional:
                if AMAVersionLocalRecordAgent.isShowUpdateView() {
                    AMAVersionInteractor.showOptionalUpdateView(selectedBlock: { (selectedIndex) in
                        if selectedIndex == 1 {
                            AMAVersionLocalRecordAgent.clearRecord()
                            self.appUpdate()
                        }
                    })
                }
            case .latest:
                AMAVersionInteractor.showLatestUpdateView(selectedBlock: nil)
                debugPrint("The App is latest version!")
            }
        }
    }
    
  
    // TODO update
    func appUpdate() {
        print("startUpdating")
    }
    

    
}
