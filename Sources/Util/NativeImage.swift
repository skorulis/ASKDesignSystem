//  Created by Alexander Skorulis on 26/12/2022.

import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
public typealias NativeImage = UIImage
#elseif canImport(AppKit)
public typealias NativeImage = NSImage
#endif
