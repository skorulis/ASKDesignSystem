//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

public struct ASKButtonStyle {
 
    private let flavor: Flavor
    private let size: Size
    
    public init(
        flavor: Flavor = .primary,
        size: Size = .medium
    ) {
        self.flavor = flavor
        self.size = size
    }
    
}

extension ASKButtonStyle: ButtonStyle {
    
    @ViewBuilder
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(size.font)
            .foregroundColor(flavor.textColor)
            .padding(size.padding)
            .background(backgroundCapsule)
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
    }
    
    @ViewBuilder
    private var backgroundCapsule: some View {
        Capsule()
            .fill(flavor.fillColor)
        if let stroke = flavor.strokeColor {
            Capsule()
                .stroke(stroke, lineWidth: 2)
        }
    }
    
}

// MARK: - Inner types

public extension ASKButtonStyle {
    enum Size: String, CaseIterable, Identifiable {
        case small
        case medium
        
        public var id: String { rawValue }
        
        var font: Font {
            switch self {
            case .small:
                return Typography.body.font
            case .medium:
                return Typography.title.font
            }
        }
        
        var padding: EdgeInsets {
            switch self {
            case .small:
                return EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10)
            case .medium:
                return EdgeInsets(top: 4, leading: 14, bottom: 4, trailing: 14)
            }
        }
    }
    
    enum Flavor: String, CaseIterable, Identifiable {
        case primary
        case outline
        case error
        
        public var id: String { rawValue }
        
        var fillColor: Color {
            switch self {
            case .primary: return .ask.brand
            case .outline: return .ask.background
            case .error: return .ask.error
            }
        }
        
        var strokeColor: Color? {
            switch self {
            case .primary: return nil
            case .outline: return .ask.primary
            case .error: return nil
            }
        }
        
        var textColor: Color {
            return .ask.contrasting(fillColor)
        }
    }
}

// MARK: - Previews

struct ASKButtonStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ForEach(ASKButtonStyle.Size.allCases) { size in
                ForEach(ASKButtonStyle.Flavor.allCases) { flavor in
                    Button(action: {}) {
                        Text("Button 1")
                    }
                    .buttonStyle(ASKButtonStyle(flavor: flavor, size: size))
                }
            }
        }
        
    }
}
