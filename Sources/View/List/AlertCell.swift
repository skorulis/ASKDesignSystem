//Created by Alexander Skorulis on 30/1/2023.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct AlertCell {
    let title: String
    let subtitle: String?
    let flavor: Flavor
    let image: Image
    
    public init(
        title: String,
        subtitle: String? = nil,
        flavor: Flavor = .brand,
        image: Image = Image(systemName: "info.circle.fill")
    ) {
        self.title = title
        self.subtitle = subtitle
        self.flavor = flavor
        self.image = image
    }
}

// MARK: - Rendering

extension AlertCell: View {
    
    public var body: some View {
        HStack {
            image
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(flavor.imageColor)
            VStack(alignment: .leading) {
                Text(title)
                    .typography(.body)
                if let subtitle {
                    Text(subtitle)
                        .typography(.caption)
                }
            }
            .foregroundColor(flavor.textColor)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(flavor.backgroundColor)
    }
}

// MARK: - Inner types

extension AlertCell  {
    public enum Flavor {
        case error, success, brand
        
        var backgroundColor: Color {
            switch self {
            case .error: return Color.ask.error.step(.one)
            case .success: return Color.ask.success.step(.one)
            case .brand: return Color.ask.brand.step(.one)
            }
        }
        
        var textColor: Color {
            return .ask.contrasting(backgroundColor)
        }
        
        var imageColor: Color {
            switch self {
            case .error: return Color.ask.error
            case .success: return Color.ask.success
            case .brand: return Color.ask.brand
            }
        }
    }
}


// MARK: - Previews

struct AlertCell_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            AlertCell(title: "Test")
            AlertCell(title: "A large title", subtitle: "And a smaller subtitle")
            AlertCell(title: "Error", flavor: .error)
            AlertCell(title: "Success", flavor: .success)
        }
    }
}

