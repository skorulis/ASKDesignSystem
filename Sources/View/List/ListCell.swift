//  Created by Alexander Skorulis on 23/1/2023.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct ListCell {
    private let title: String
    private let subtitle: String?
    
    public init(title: String,
                subtitle: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
    }
}

// MARK: - Rendering

extension ListCell: View {
    
    public var body: some View {
        HStack {
            textContent
            Spacer()
            ASKIcon.chevronLeft.small
                .rotationEffect(.degrees(180))
        }
        .padding(8)
        .contentShape(Rectangle())
    }
    
    private var textContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .typography(.body)
            if let subtitle {
                Text(subtitle)
                    .typography(.caption)
            }
        }
    }
}

// MARK: - Previews

struct ListCell_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ListCell(title: "List row")
            
            ListCell(
                title: "Another list row",
                subtitle: "With a sub title here"
            )
        }
        
    }
}

