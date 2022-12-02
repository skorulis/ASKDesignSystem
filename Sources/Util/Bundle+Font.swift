//  Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

public extension Bundle {
    
    static var fontFullNames: [String: String] = [:]
    
    func registerFont(name: String, ext: String) {
        guard let url = url(forResource: name, withExtension: ext) else {
            fatalError("Could not load font file \(name).\(ext)")
        }
        guard let data = try? Data(contentsOf: url),
              let dataRef = CGDataProvider(data: data as CFData),
              let font = CGFont(dataRef) else {
            fatalError("Could not create font for \(name).\(ext)")
        }
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print(error!.takeUnretainedValue())
        }
        
        guard let full = font.fullName as? String else { return }
        Self.fontFullNames[name] = full
        
    }
    
}
