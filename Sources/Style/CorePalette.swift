//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

public struct CorePalette {
    
    static var red = Color(0xe74c3c)
    static var orange = Color(0xfb8500)
    static var blue = Color(0x8ecae6)
    static var teal = Color(0x219ebc)
    static var yellow = Color(0xffb703)
    static var green = Color(0x2ecc71)
    static var purple = Color(0x9b59b6)
    static var black = Color(0x0A0A0A)
    
    public let primary: Color = black
    public let secondaryText: Color = black.lighten(percentage: 0.4)
    public let brand: Color = blue
    public let secondary: Color = teal
    public let tertiary: Color = yellow
    public let error: Color = orange
    public let background: Color = .white //Color(0xF0F0F0, alpha: 1)
    
}

// MARK: - Semantic colors

extension CorePalette {
    
    public var navBarBackground: Color {
        brand.saturate(percentage: -0.1)
    }
    
}

extension Color {
    static var ask: CorePalette = CorePalette()
}

// MARK: - Previews

struct CorePalette_Previews: PreviewProvider {
 
    struct ColorItem: Identifiable {
        let color: Color
        let name: String
        
        var id: String { name }
        
        var contrast1: CGFloat {
            return color.contrastRatio(with: .ask.primary)
        }
        
        var contrast2: CGFloat {
            return color.contrastRatio(with: .ask.background)
        }
    }
    
    static var items: [ColorItem] {
        return [
            .init(color: .ask.primary, name: "primary"),
            .init(color: .ask.secondaryText, name: "secondaryText"),
            .init(color: .ask.background, name: "background"),
            .init(color: .ask.brand, name: "brand"),
            .init(color: .ask.secondary, name: "secondary"),
            .init(color: .ask.tertiary, name: "tertiary"),
            .init(color: .ask.error, name: "error"),
        ]
    }
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(items) { item in
                ZStack(alignment: .leading) {
                    item.color
                    VStack(alignment: .leading) {
                        Text("\(item.name) \(item.contrast1)")
                            .typography(.title)
                            .foregroundColor(.ask.primary)
                        
                        Text("\(item.name) \(item.contrast2)")
                            .typography(.title)
                            .foregroundColor(.ask.background)
                    }
                    .padding(10)
                }
                .frame(height: 70)
                
            }
            
        }
    }
    
}
