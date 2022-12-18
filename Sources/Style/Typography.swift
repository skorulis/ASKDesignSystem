//  Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

public enum Typography: String, CaseIterable, Identifiable {
    
    case headline
    case title
    case subtitle
    case body
    case smallBody
    case caption
    
}

public extension Typography {
    
    var size: CGFloat {
        switch self {
        case .headline: return 48
        case .title: return 24
        case .subtitle: return 22
        case .body: return 18
        case .smallBody: return 16
        case .caption: return 12
        }
    }
    
    var fontName: FontName {
        switch self {
        case .headline: return .bold
        case .title: return .bold
        case .subtitle: return .bold
        case .body: return .medium
        case .smallBody: return .medium
        case .caption: return .light
        }
    }
    
    var font: Font {
        return fontName.font(size)
    }
    
    var id: String { rawValue }
    
}

public extension Text {
    
    func typography(_ type: Typography) -> Text {
        self
            .font(type.font)
    }
    
}

// MARK: - Previews

struct Typography_Previews: PreviewProvider {
 
    static var previews: some View {
        VStack(alignment: .leading) {
            ForEach(Typography.allCases) { typo in
                Text(typo.rawValue.capitalized)
                    .typography(typo)
            }
        }
    }
    
}
