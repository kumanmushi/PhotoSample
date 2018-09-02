//
//  UIView+Border.swift
//  Client
//
//  Created by 村田真矢 on 2018/07/15.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit

extension UIView {
    
    enum BorderPosition {
        case top
        case left
        case right
        case bottom
    }
    
    // 枠線の色
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // 枠線のWidth
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // 角丸設定
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
