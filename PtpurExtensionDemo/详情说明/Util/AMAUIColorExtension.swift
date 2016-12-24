//
//  UIImageExtension.swift
//  PtpurExtensionDemo
//
//  Created by 吴玉铁 on 2016/12/24.
//  Copyright © 2016年 wuyutie. All rights reserved.
//

import UIKit

func RGBColor (r: Float, g: Float, b: Float) -> UIColor {
    return RGBAColor(r: r, g: g, b: b, a: 1.0)
}

func RGBAColor(r: Float, g: Float, b: Float, a: Float) -> UIColor {
    return UIColor(colorLiteralRed: r / 255.0, green: r / 255.0, blue: r / 255.0, alpha: a)
}

extension UIImage {
    static func imageWithColor(color: UIColor?) -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor((color ?? UIColor.white).cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
