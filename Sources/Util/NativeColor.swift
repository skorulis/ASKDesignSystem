//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
typealias NativeColor = UIColor
#elseif canImport(AppKit)
typealias NativeColor = NSColor
#endif

extension Color {
    
    init(nativeColor: NativeColor) {
#if canImport(UIKit)
        self.init(uiColor: nativeColor)
#elseif canImport(AppKit)
        self.init(nsColor: nativeColor)
#endif
    }
}
