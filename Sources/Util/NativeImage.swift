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

public extension NativeImage {
    static func parseImage(from data: Data) throws -> NativeImage {
    #if os(macOS)
            if let nsImage = NSImage(data: data) {
                return nsImage
            } else {
                throw NativeImage.LoadingError.parseFailure(data)
            }
    #else
            if let uiImage = UIImage(data: data, scale: scale) {
                return uiImage
            } else {
                throw NativeImage.LoadingError.parseFailure(data)
            }
    #endif
        }
}

extension NativeImage {
    
    enum LoadingError: LocalizedError {
        case parseFailure(Data)
        
        var errorDescription: String? {
            switch self {
            case .parseFailure(let data):
                if data.count > 10000 {
                    return "Could not parse data, length \(data.count)"
                } else if let string = String(data: data, encoding: .utf8) {
                    return "Could not parse \(string)"
                } else {
                    return "Could not parse data, length \(data.count)"
                }
            }
        }
    }
    
}
