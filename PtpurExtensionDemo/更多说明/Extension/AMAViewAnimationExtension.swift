//
//  AMAViewAnimationExtension.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/26.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

extension UIView{
    func alertSpringAnimation(animaition: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: .curveEaseInOut, animations: animaition, completion: completion)
    }
    
    func alertSpringAnimation(animaition: @escaping () -> Void) {
        self.alertSpringAnimation(animaition: animaition, completion: nil)
    }
    
    func alertDismissAnimation(animaition: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: animaition, completion: completion)
    }
}
