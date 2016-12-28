//
//  AMAMoreInstructionInteractor.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/28.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class AMAMoreInstructionInteractor: NSObject {
    
    static func showMoreInstructionView() {
        let insView = AMAMoreInstructionsView.initFromNib()
        insView.frame = UIScreen.main.bounds
        insView.showAnimation()
        AMAMoreInstructionInteractor.showInWindow(view: insView)
    }
    
    private static func showInWindow(view: UIView) {
        UIApplication.shared.keyWindow?.addSubview(view)
    }
}
