//
//  AMAInstructionEntity.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/24.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class AMAInstructionDisplayData: NSObject {
    var topImage: UIImage?
    var titleLabelText: String?
    var messageLabelText: String?
    
    init(image: UIImage?, title: String?, message: String?) {
        super.init()
        topImage = image
        titleLabelText = title
        messageLabelText = message
    }
    
}
