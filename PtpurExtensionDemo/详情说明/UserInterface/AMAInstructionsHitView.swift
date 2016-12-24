

//
//  hitView.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/24.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class AMAInstructionsHitView: UIView {

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var hitTestView = super.hitTest(point, with: event)
        if hitTestView != nil, hitTestView is AMAInstructionsHitView {
            if let subView = self.subviews.first as? UIScrollView {
                hitTestView = subView
            }
        }
        return hitTestView
    }

}
