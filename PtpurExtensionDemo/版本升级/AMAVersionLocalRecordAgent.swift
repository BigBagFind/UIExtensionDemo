//
//  AMAVersionLocalRecordAgent.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2017/1/1.
//  Copyright © 2017年 wuyutie. All rights reserved.
//

import UIKit

let AMAVersionUpdateRefuseRecordKey = "kUpdateRefuseRecord"
let AMAApplicationBecomeActiveRecordKey = "kBecomeActiveRecord"
class AMAVersionLocalRecordAgent: NSObject {
    
    
    // MARK:- App今日启动记录
    static func isAppFirstBecomeActiveToday() -> Bool {
        if self.getFirstActiveRecord().isEmpty {
            self.setFirstActiveRecord(record: self.getTodayDate())
            return true
        } else {
            if self.getFirstActiveRecord() != self.getTodayDate() {
                self.setFirstActiveRecord(record: self.getTodayDate())
                return true
            }
        }
        return false
    }
    
    static func getFirstActiveRecord() -> String {
        return UserDefaults.standard.object(forKey: AMAApplicationBecomeActiveRecordKey) as? String ?? ""
    }
    
    private static func setFirstActiveRecord(record: String?) {
        self.setObj(record ?? "", forKey: AMAApplicationBecomeActiveRecordKey)
    }
    
    
    // MARK:- 稍后再说记录
    static func isShowUpdateView() -> Bool {
        if AMAVersionLocalRecordAgent.getRecord().count > 2 {
            return false
        }
        return !haveTodayRecord()
    }
    
    static func writeTodayToLocal() {
        var newRecord = self.getRecord()
        newRecord.append(self.getTodayDate())
        let filterRecord = Array(Set(newRecord))
        self.setRecord(record: filterRecord)
    }
    
    static func clearRecord() {
        UserDefaults.standard.set([String](), forKey: AMAVersionUpdateRefuseRecordKey)
        UserDefaults.standard.synchronize()
    }

    static func getRecord() -> Array<String> {
        return UserDefaults.standard.object(forKey: AMAVersionUpdateRefuseRecordKey) as? Array<String> ?? [String]()
    }

    static func haveTodayRecord() -> Bool {
        for item in AMAVersionLocalRecordAgent.getRecord() {
            if item == self.getTodayDate() {
                return true
            }
        }
        return false
    }
    
    static func getTodayDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    private static func setRecord(record: [String]?) {
        let recordData = record ?? [String]()
        self.setObj(recordData, forKey: AMAVersionUpdateRefuseRecordKey)
    }
    
    private static func setObj(_ value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
