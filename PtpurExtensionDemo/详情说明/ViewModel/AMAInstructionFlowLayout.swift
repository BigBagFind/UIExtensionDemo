//
//  AMAInstructionFlowLayout.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/25.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class AMAInstructionFlowLayout: UICollectionViewFlowLayout {
    var offsetPoint: CGPoint
    
    init(contentOffsetPoint: CGPoint) {
        offsetPoint = contentOffsetPoint
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        self.collectionView?.contentOffset = offsetPoint
    }
    
}
