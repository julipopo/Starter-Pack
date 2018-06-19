//
//  Codable+Extension.swift
//  init_project
//
//  Created by julien on 18/06/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    @discardableResult func normal(_ text: String, font: UIFont) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: font]
        let normal = NSMutableAttributedString(string: text, attributes: attrs)
        append(normal)
        
        return self
    }
    
    @discardableResult func striped(_ text: String, font: UIFont) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: font, .strikethroughStyle: 2]
        let normal = NSMutableAttributedString(string: text, attributes: attrs)
        append(normal)
        
        return self
    }
}

extension UIButton {
    override open func awakeFromNib() {
        for state in [UIControlState.normal, UIControlState.highlighted, UIControlState.selected, UIControlState.disabled] {
            if let title = title(for: state) {
                setTitle(title.localized, for: state)
            }
        }
    }
    
    func setTitleForAllEnabledStates(_ title: String) {
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .selected)
        self.setTitle(title, for: .disabled)
    }
}

extension UIColor {
    var toHexString: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        let rgb = UIColor.commonInit(fromHex: hex)
        
        self.init(
            red: rgb.r / 0xff,
            green: rgb.g / 0xff,
            blue: rgb.b / 0xff, alpha: alpha
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: 1
        )
    }
    
    class func commonInit(fromHex hex: String) -> (r: CGFloat, g: CGFloat, b: CGFloat) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        return (CGFloat(r), CGFloat(g), CGFloat(b))
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(value) {
            let newFrame = CGRect(x: value, y: frame.minY, width: frame.width, height: frame.height)
            frame = newFrame
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(value) {
            let newFrame = CGRect(x: frame.minX, y: value, width: frame.width, height: frame.height)
            frame = newFrame
        }
    }
    
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(value) {
            let newFrame = CGRect(x: frame.minX, y: frame.minY, width: value, height: frame.height)
            frame = newFrame
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(value) {
            let newFrame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: value)
            frame = newFrame
        }
    }
}
