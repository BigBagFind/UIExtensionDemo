//
//  AMAVersionService.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/31.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

enum AMAVersionUpdateType {
    case forced          // 强制更新
    case optional        // 可选更新
    case latest          // 最新版本了，无需更新
}

class AMAVersionService: NSObject {
    
    func fetchLatestVersion(completion: @escaping (AMAVersionUpdateType) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.optional)
        }
    }
}
