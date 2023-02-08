//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

public struct CorePalette {
    
    static var red = Color(0xc0392b)
    static var orange = Color(0xfed9b7)
    static var pink = Color(0xf72585)
    static var blue = Color(0x2980b9)
    static var teal = Color(0x00afb9)
    static var purple = Color(0x8e44ad)
    static var yellow = Color(0xf1c40f)
    static var green = Color(0x27ae60)
    static var black = Color(0x0A0A0A)
    static var white = Color(0xFFFFFF)
    
    public let primary: Color = black
    public let secondaryText: Color = black.lighten(percentage: 0.4)
    public let brand: Color = blue
    public let secondary: Color = purple
    public let tertiary: Color = yellow
    public let success: Color = green
    public let error: Color = red
    public let background: Color = .white //Color(0xF0F0F0, alpha: 1)
    
    public func contrasting(_ color: Color) -> Color {
        return cache.contrasts[color] ?? self.primary
    }
    
    private var cache: CorePaletteCache!
    
    private func buildCache() -> CorePaletteCache {
        var contrasts = [Color: Color]()
        let toCheck = [
            Self.blue,
            Self.green,
            Self.orange,
            Self.pink,
            Self.purple,
            Self.red,
            Self.teal,
            Self.yellow
        ]
        let options = [self.primary, self.background]
        for col in toCheck {
            for step in PaletteStep.allCases {
                let adjusted = col.step(step)
                contrasts[adjusted] = CorePaletteCache.contrasting(adjusted, options)
            }
            
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

public extension Color {
    static var ask: CorePalette = CorePalette()
    
    func step(_ num: PaletteStep) -> Color {
        return self.lighten(percentage: num.lightness)
    }
}

public enum PaletteStep: String, CaseIterable, Identifiable {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var lightness: CGFloat {
        switch self {
        case .zero: return 0.44
        case .one: return 0.4
        case .two: return 0.36
        case .three: return 0.27
        case .four: return 0.18
        case .five: return 0.09
        case .six: return 0
        case .seven: return -0.09
        case .eight: return -0.18
        case .nine: return -0.27
        }
    }
    
    public var id: String { rawValue }
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
            .init(color: .ask.success, name: "success"),
            .init(color: .ask.error, name: "error"),
        ]
    }
    
    @ViewBuilder
    static var previews: some View {
        basePalette
            .previewDisplayName("Base Palette")
        HStack {
            scale(color: .ask.success)
            scale(color: .ask.error)
            scale(color: .ask.brand)
            scale(color: .ask.secondary)
            scale(color: .ask.tertiary)
        }
            .previewDisplayName("Scale")
        
    }
    
    private static func scale(color: Color) -> some View {
        VStack {
            ForEach(PaletteStep.allCases) { step in
                ColorStepCell(color: color, step: step)
            }
        }
    }
    
    private static var basePalette: some View {
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
    
    struct ColorStepCell: View {
        let color: Color
        let step: PaletteStep
        
        var body: some View {
            ZStack(alignment: .leading) {
                color.step(step)
                    .frame(height: 50)
                Text(step.rawValue)
                    .foregroundColor(.ask.contrasting(adjustedColor))
                    .padding()
            }
        }
        
        private var adjustedColor: Color { color.step(step) }
        
    }
    
}
