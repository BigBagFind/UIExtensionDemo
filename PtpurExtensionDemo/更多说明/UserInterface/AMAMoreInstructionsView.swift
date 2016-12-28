//
//  AMAMoreInstructionsView.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/26.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class AMAMoreInstructionsView: UIView {
    @IBOutlet weak var backgroundMask: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var totalAssetLabel: UILabel!
    @IBOutlet weak var stockLimitLabel: UILabel!
    @IBOutlet weak var avaliableCashLabel: UILabel!
    @IBOutlet weak var strategyLimitLabel: UILabel!
    @IBOutlet weak var tipMessageLabel: UILabel!
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismissAnimation()
    }
    
    static func initFromNib() -> AMAMoreInstructionsView {
        return Bundle.main.loadNibNamed("AMAMoreInstructionsView", owner: self, options: nil)?.last as! AMAMoreInstructionsView
    }
    
    func bindViewModel(_ viewModel: Any) {
        
    }
    
    func showAnimation() {
        self.backgroundMask.alpha = 0
        self.alertView.layer.setAffineTransform(CGAffineTransform(scaleX: 0.6,y: 0.6))
        self.alertSpringAnimation {
            self.alertView.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0,y: 1.0))
            self.backgroundMask.alpha = 1.0
        }
    }
    
    func dismissAnimation() {
        self.alertDismissAnimation(animaition: { 
            self.alpha = 0.0
            self.alertView.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1,y: 0.1))
        }) { (completed) in
            self.removeFromSuperview()
        }
    }
    
    

}
