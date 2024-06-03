//
//  MWColorPickerHelper.swift
//  MWColorPicker
//
//  Created by LiYing on 2024/5/29.
//

import UIKit

public struct MWColorPickerSelectBoxStyle {
    public enum BorderColor {
        case auto
        case color(UIColor)
    }
    public var icon: UIImage?
    public var iconColor: BorderColor = .auto
    public var cornerRadius: CGFloat = 0
    public static let `default` = MWColorPickerSelectBoxStyle()
}

extension UIColor {
    static func hex(_ hex: String) -> UIColor {
        var cStr = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cStr.hasPrefix("#") {
            cStr.remove(at: cStr.startIndex)
        }
        
        if cStr.count != 6 {
            return .gray
        }
        
        var r: UInt32 = 0
        Scanner(string: cStr).scanHexInt32(&r)
        
        let red = CGFloat((r & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((r & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(r & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIColor {
    
    /// https://gist.github.com/gotev/76df9006674762859626846cf171ff80
    
    var redValue: CGFloat{
        return cgColor.components![0]
    }
    
    var greenValue: CGFloat{
        return cgColor.components![1]
    }
    
    var blueValue: CGFloat{
        return cgColor.components![2]
    }
    
    var alphaValue: CGFloat{
        return cgColor.components![3]
    }
    
    /// 是否亮背景
    var isLight: Bool {
        
        // non-RGB color
        if cgColor.numberOfComponents == 2 {
            return 0.0...0.5 ~= cgColor.components!.first! ? true : false
        }
        
        let red = self.redValue
        let green = self.greenValue
        let blue = self.blueValue
        
        // https://en.wikipedia.org/wiki/YIQ
        // https://24ways.org/2010/calculating-color-contrast/
        let yiq = ((red * 299) + (green * 587) + (blue * 114)) / 1000
        return yiq >= 0.5 // 192?
    }
}

extension CGFloat {
    
    /// 截取小数点后小数，不考虑四舍五入
    /// - Parameter places: 保留小数点后几位
    /// - Returns: CGFloat
    func truncate(places : UInt)-> CGFloat {
        return CGFloat(floor(pow(10.0, Double(places)) * Double(self)) / pow(10.0, Double(places)))
    }
}

extension Bundle {
    static func resourceUrl(forClass className: AnyClass,
                            forBundle bundleName: String,
                            forResource name: String,
                            withExtension ext: String) -> URL? {
        var bundle: Bundle? = Bundle.main
        if let url = Bundle(for: className).url(forResource: bundleName, withExtension: "bundle") {
            bundle = Bundle(url: url)
        }
        
        return bundle?.url(forResource: name, withExtension: ext)
    }
}

extension UIImage {
    static func resourceUrl(forClass className: AnyClass,
                            forBundle bundleName: String,
                            forResource name: String,
                            withExtension ext: String) -> UIImage? {
        
        var bundle: Bundle? = Bundle.main
        if let url = Bundle(for: className).url(forResource: bundleName, withExtension: "bundle") {
            bundle = Bundle(url: url)
        }
        if #available(iOS 13.0, *) {
            return UIImage(named: name, in: bundle, with: nil)
        } else {
            // Fallback on earlier versions
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
    }
}
