//  Created by Alexander Skorulis on 24/7/2022.

import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
import SwiftUI

extension NativeColor {
    
    convenience init(_ hex: UInt, alpha: Double = 1) {
        self.init(
          red: Double((hex >> 16) & 0xFF) / 255,
          green: Double((hex >> 8) & 0xFF) / 255,
          blue: Double(hex & 0xFF) / 255,
          alpha: alpha
        )
    }
    
    convenience init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) {
        precondition(0...1 ~= hue && 0...1 ~= saturation && 0...1 ~= lightness && 0...1 ~= alpha, "input range is out of range 0...1")
                
        //From HSL TO HSB ---------
        var newSaturation: CGFloat = 0.0
        
        let brightness = lightness + saturation * min(lightness, 1-lightness)
        
        if brightness == 0 { newSaturation = 0.0 }
        else {
            newSaturation = 2 * (1 - lightness / brightness)
        }
        //---------
        
        self.init(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
    }
    
    var hsba: (CGFloat, CGFloat, CGFloat, CGFloat) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h,s,b,a)
    }
    
    var hsla: (CGFloat, CGFloat, CGFloat, CGFloat) {
        var (h, s, b, a) = hsba
        let l = ((2.0 - s) * b) / 2.0
        switch l {
        case 0.0, 1.0:
            s = 0.0
        case 0.0..<0.5:
            s = (s * b) / (l * 2.0)
        default:
            s = (s * b) / (2.0 - l * 2.0)
        }
        return (h, s, l, a)
    }
    
    var rgba: (CGFloat, CGFloat, CGFloat, CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (r, g, b, a)
    }
    
    var brightness: CGFloat {
        return hsba.2
    }
    
    var saturation: CGFloat {
        return hsba.1
    }
    
    func saturate(percentage: CGFloat) -> NativeColor {
        var (h, s, b, a) = hsba
        s = min(max(s + percentage, 0), 1);
        return NativeColor(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    
    func mix(other: NativeColor, pct: CGFloat) -> NativeColor {
        let (r1, g1, b1, a1) = rgba
        let (r2, g2, b2, a2) = other.rgba
        let pI = 1 - pct
        
        let r = r1 * pI + r2 * pct
        let g = g1 * pI + g2 * pct
        let b = b1 * pI + b2 * pct
        let a = a1 * pI + a2 * pct
        return NativeColor(red: r, green: g, blue: b, alpha: a)
    }
    
    private func adjustBrightness(percentage: CGFloat) -> NativeColor {
        var (h, s, b, a) = hsba
        b = min(max(b + percentage, 0), 1);
        return NativeColor(hue: h, saturation: s, brightness: b, alpha: a)
    }
    
    func lighten(percentage: CGFloat) -> NativeColor {
        var col = self.hsla
        col.2 += percentage
        col.2 = max(min(col.2, 1), 0)
        return NativeColor(
            hue: col.0,
            saturation: col.1,
            lightness: col.2,
            alpha: col.3
        )
    }
    
}

internal extension NativeColor {
    
    static func contrastRatio(between color1: NativeColor, and color2: NativeColor) -> CGFloat {
        // https://www.w3.org/TR/WCAG20-TECHS/G18.html#G18-tests

        let luminance1 = color1.luminance()
        let luminance2 = color2.luminance()

        let luminanceDarker = min(luminance1, luminance2)
        let luminanceLighter = max(luminance1, luminance2)

        return (luminanceLighter + 0.05) / (luminanceDarker + 0.05)
    }

    func contrastRatio(with color: NativeColor) -> CGFloat {
        return NativeColor.contrastRatio(between: self, and: color)
    }

    func luminance() -> CGFloat {
        // https://www.w3.org/TR/WCAG20-TECHS/G18.html#G18-tests

        #if canImport(UIKit)
        let ciColor = CIColor(color: self)
        #elseif canImport(AppKit)
        let ciColor = CIColor(color: self)!
        #endif

        func adjust(colorComponent: CGFloat) -> CGFloat {
            return (colorComponent < 0.04045) ? (colorComponent / 12.92) : pow((colorComponent + 0.055) / 1.055, 2.4)
        }

        return 0.2126 * adjust(colorComponent: ciColor.red) + 0.7152 * adjust(colorComponent: ciColor.green) + 0.0722 * adjust(colorComponent: ciColor.blue)
    }
    
    var swiftUI: Color {
        return Color(nativeColor: self)
    }
    
    static func dynamicColor(light: NativeColor, dark: NativeColor) -> NativeColor {
#if canImport(UIKit)
        return NativeColor { traits in
            switch traits.userInterfaceStyle {
            case .dark: return dark
            default: return light
            }
        }
#else
        return light
#endif
    }
}
