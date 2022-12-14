//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

public struct CorePalette {
    
    static var red = Color(0xf07167)
    static var orange = Color(0xfed9b7)
    static var pink = Color(0xf72585)
    static var blue = Color(0x0081a7)
    static var teal = Color(0x00afb9)
    static var yellow = Color(0xfdfcdc)
    static var green = Color(0x2ecc71)
    static var purple = Color(0x9b59b6)
    static var black = Color(0x0A0A0A)
    static var white = Color(0xFFFFFF)
    
    public let primary: Color = black
    public let secondaryText: Color = black.lighten(percentage: 0.4)
    public let brand: Color = blue
    public let secondary: Color = teal
    public let tertiary: Color = yellow
    public let error: Color = red
    public let background: Color = .white //Color(0xF0F0F0, alpha: 1)
    
    public func contrasting(_ color: Color) -> Color {
        return cache.contrasts[color] ?? self.primary
    }
    
    private var cache: CorePaletteCache!
    
    private func buildCache() -> CorePaletteCache {
        var contrasts = [Color: Color]()
        let toCheck = [
            Self.red,
            Self.orange,
            Self.pink,
            Self.blue,
            Self.teal,
            Self.yellow
        ]
        let options = [self.primary, self.background]
        for col in toCheck {
            contrasts[col] = CorePaletteCache.contrasting(col, options)
        }
        return CorePaletteCache(contrasts: contrasts)
    }
    
    public init() {
        self.cache = buildCache()
    }
}

struct CorePaletteCache {
    
    let contrasts: [Color: Color]
    
    fileprivate static func contrasting(_ color: Color, _ options: [Color]) -> Color {
        var best = options[0]
        var bestValue = color.contrastRatio(with: options[0])
        for opt in options {
            let contrast = color.contrastRatio(with: opt)
            if contrast > bestValue {
                bestValue = contrast
                best = opt
            }
        }
        return best
    }
    
}

// MARK: - Semantic colors

extension CorePalette {
    
    public var navBarBackground: Color {
        CorePalette.black
    }
    
    public var navBarContent: Color {
        CorePalette.white
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
