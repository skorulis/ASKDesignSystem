//  Created by Alexander Skorulis on 26/12/2022.

import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
typealias NativeImage = UIImage
#elseif canImport(AppKit)
typealias NativeImage = NSImage
#endif
