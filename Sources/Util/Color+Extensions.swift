//  Created by Alexander Skorulis on 19/12/21.

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

import simd

public extension Color {
    
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
          .sRGB,
          red: Double((hex >> 16) & 0xFF) / 255,
          green: Double((hex >> 8) & 0xFF) / 255,
          blue: Double(hex & 0xFF) / 255,
          opacity: alpha
        )
    }
    
    init?(_ hex: String) {
        var str = hex
        if str.hasPrefix("#") {
          str.removeFirst()
        }
        if str.count == 3 {
          str = String(repeating: str[str.startIndex], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 1)], count: 2)
            + String(repeating: str[str.index(str.startIndex, offsetBy: 2)], count: 2)
        } else if !str.count.isMultiple(of: 2) || str.count > 8 {
          return nil
        }
        let scanner = Scanner(string: str)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        if str.count == 2 {
          let gray = Double(Int(color) & 0xFF) / 255
          self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)
        } else if str.count == 4 {
          let gray = Double(Int(color >> 8) & 0x00FF) / 255
          let alpha = Double(Int(color) & 0x00FF) / 255
          self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)
        } else if str.count == 6 {
          let red = Double(Int(color >> 16) & 0x0000FF) / 255
          let green = Double(Int(color >> 8) & 0x0000FF) / 255
          let blue = Double(Int(color) & 0x0000FF) / 255
          self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)
        } else if str.count == 8 {
          let red = Double(Int(color >> 24) & 0x000000FF) / 255
          let green = Double(Int(color >> 16) & 0x000000FF) / 255
          let blue = Double(Int(color >> 8) & 0x000000FF) / 255
          let alpha = Double(Int(color) & 0x000000FF) / 255
          self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
        } else {
          return nil
        }
      }
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o)


        return (r, g, b, o)
    }
    
    var simd: simd_float4 {
        let comps = components
        return simd_float4(x: Float(comps.red), y: Float(comps.green), z: Float(comps.blue), w: Float(comps.opacity))
    }
    
    var hexString: String {
        let (r,g,b,_) = components
        
        let hex: String = [r, g, b]
            .map { Int(round($0 * CGFloat(255)))}
            .map { String(format: "%02X", $0)}
            .joined()
        
        return "#\(hex)"
    }
    
    var luminance: CGFloat {
        let (rI, gI, bI, _) = components
        let r = convertSrgbLuminance(rI)
        let g = convertSrgbLuminance(gI)
        let b = convertSrgbLuminance(bI)
        return (r * 0.2126) + (g * 0.7152) + (b * 0.0722);
    }
    
    private func convertSrgbLuminance(_ input: CGFloat)  -> CGFloat {
        if (input > 0.03928) {
            return pow((input+0.055)/1.055,2.4);
        } else {
            return input / 12.92;
        }
    }
    
    func darken(percentage: CGFloat) -> Color {
        let uiColor = NativeColor(self).darken(percentage: percentage)
        return Color(nativeColor: uiColor)
    }
    
    func mix(other: Color, pct: CGFloat) -> Color {
        let uiColor = NativeColor(self).mix(other: NativeColor(other), pct: pct)
        return Color(nativeColor: uiColor)
    }
    
    func lighten(percentage: CGFloat) -> Color {
        let uiColor = NativeColor(self).lighten(percentage: percentage)
        return Color(nativeColor: uiColor)
    }
    
    var hsba: (CGFloat, CGFloat, CGFloat, CGFloat) {
        return NativeColor(self).hsba
    }
    
    var brightness: CGFloat {
        return NativeColor(self).brightness
    }
    
    var saturation: CGFloat {
        return NativeColor(self).saturation
    }
    
}
