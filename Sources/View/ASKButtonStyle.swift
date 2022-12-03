//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

public struct ASKButtonStyle {
 
    private let flavor: Flavor
    
    public init(flavor: Flavor = .primary) {
        self.flavor = flavor
    }
    
}

extension ASKButtonStyle: ButtonStyle {
    
    @ViewBuilder
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Typography.title.font)
            .foregroundColor(.ask.primary)
            .padding(EdgeInsets(top: 4, leading: 14, bottom: 4, trailing: 14))
            .background(backgroundCapsule
            )
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
    }
}

// MARK: - Previews

struct ASKButtonStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ForEach(ASKButtonStyle.Flavor.allCases) { flavor in
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(ASKButtonStyle(flavor: flavor))
            }
        }
        
    }
}
