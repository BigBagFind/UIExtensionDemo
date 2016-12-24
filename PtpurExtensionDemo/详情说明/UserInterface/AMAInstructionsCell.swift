
//
//  AMAInstructionsCell.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/22.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

class AMAInstructionsCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.okButton.setBackgroundImage(UIImage.imageWithColor(color: nil), for: .normal)
        self.okButton.setBackgroundImage(UIImage.imageWithColor(color: RGBColor(r: 240, g: 240, b: 240)), for: .highlighted)
    }
    
    func bindViewModel(_ ViewModel: Any) {
        if let vm = ViewModel as? AMAInstructionDisplayData {
            self.titleLabel.text = vm.titleLabelText
            self.messageLabel.text = vm.messageLabelText
            self.imageView.image = vm.topImage
        }
    }
    
 

}
