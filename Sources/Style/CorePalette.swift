//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

enum CorePalette {
    
    static var red = Color(0xe74c3c, alpha: 1)
    static var blue = Color(0x3498db, alpha: 1)
    static var green = Color(0x2ecc71, alpha: 1)
    static var purple = Color(0x9b59b6, alpha: 1)
    
    static var primary: Color = Color(0x0A0A0A, alpha: 1)
    static var brand: Color = blue
    static var secondary: Color = green
    static var tertiary: Color = purple
    static var error: Color = red
    static var background: Color = .white //Color(0xF0F0F0, alpha: 1)
    
}

// MARK: - Previews

struct CorePalette_Previews: PreviewProvider {
 
    struct ColorItem: Identifiable {
        let color: Color
        let name: String
        
        var id: String { name }
        
        var contrast1: CGFloat {
            return color.contrastRatio(with: CorePalette.primary)
        }
        
        var contrast2: CGFloat {
            return color.contrastRatio(with: CorePalette.background)
        }
    }
    
    static var items: [ColorItem] {
        return [
            .init(color: CorePalette.primary, name: "primary"),
            .init(color: CorePalette.background, name: "background"),
            .init(color: CorePalette.brand, name: "brand"),
            .init(color: CorePalette.secondary, name: "secondary"),
            .init(color: CorePalette.tertiary, name: "tertiary"),
            .init(color: CorePalette.error, name: "error"),
        ]
    }
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(items) { item in
                ZStack(alignment: .leading) {
                    item.color
                    VStack {
                        Text("\(item.name) \(item.contrast1)")
                            .typography(.title)
                            .foregroundColor(CorePalette.primary)
                        
                        Text("\(item.name) \(item.contrast2)")
                            .typography(.title)
                            .foregroundColor(CorePalette.background)
                    }
                    .padding(10)
                }
                .frame(height: 70)
                
            }
            
        }
    }
    
}
