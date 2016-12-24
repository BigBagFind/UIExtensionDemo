//
//  AMAInstructionsViewModel.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/24.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

protocol AMAInstructionsViewModelProtocal {
    var instructionsData: [AMAInstructionDisplayData] { get }
    var initPageIndex: Int  { get }
    
    func pageControlCurrentIndex(offsetX: Double) -> Int
    func itemDisplayData(indexPath: IndexPath) -> AMAInstructionDisplayData
}


class AMAInstructionsViewModel: NSObject, AMAInstructionsViewModelProtocal {
    var instructionsData: [AMAInstructionDisplayData]
    var initPageIndex: Int
    
    init(pageIndex: Int) {
        instructionsData = []
        initPageIndex = pageIndex
        super.init()
        self.loadInstructionsData()
    }
    
    func itemDisplayData(indexPath: IndexPath) -> AMAInstructionDisplayData {
        return self.instructionsData[indexPath.item]
    }
    
    func pageControlCurrentIndex(offsetX: Double) -> Int {
        let offsetX = Double(offsetX)
        let indexOfDouble = offsetX / ItemWidth
        var indexOfInt = Int(indexOfDouble)
        if Int(indexOfDouble + 0.5) > indexOfInt {
            indexOfInt += 1
        }
        return indexOfInt
    }
    
    private func loadInstructionsData() {
        let fileName = Bundle.main.path(forResource: InstructionsKey, ofType: "plist")
        guard let name = fileName else {
            return
        }
        
        let list = NSArray(contentsOfFile: name)
        for item in list! {
            let entity = AMAInstructionEntity()
            entity.title = (item as! NSDictionary).object(forKey: "title") as! String?
            entity.message = (item as! NSDictionary).object(forKey: "message") as! String?
            entity.imageName = (item as! NSDictionary).object(forKey: "imageName") as! String?
            let displayData = self.transfromToDisplyData(entity: entity)
            instructionsData.append(displayData)
        }
    }
    
    private func transfromToDisplyData(entity: AMAInstructionEntity) -> AMAInstructionDisplayData {
        let imagePath = Bundle.main.path(forResource: entity.imageName, ofType: "png")
        let displayData = AMAInstructionDisplayData(image: UIImage(contentsOfFile: imagePath!), title: entity.title ?? "暂无标题", message: entity.message ?? "暂无说明")
        return displayData
    }
    
}
