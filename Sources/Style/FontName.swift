//  Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif


enum FontName: String, CaseIterable {
    
    case light = "Figtree-Light"
    case medium = "Figtree-Medium"
    case bold = "Figtree-Bold"
    
    public func font(_ size: CGFloat) -> Font {
        _ = FontName.registerFontsOnce
        return Font.custom(rawValue, size: size)
    }
    
    var ext: String {
        return "ttf"
    }
    
    var name: String { rawValue }
    
}

private extension FontName {
    
    private static let registerFontsOnce: () = {
#if canImport(UIKit)
        _ = UIFont.familyNames
#endif
        
        for font in allCases {
            Bundle.workaround.registerFont(name: font.rawValue, ext: font.ext)
        }
    }()
    
}
