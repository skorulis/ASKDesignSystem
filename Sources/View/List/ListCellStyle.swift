//Created by Alexander Skorulis on 16/3/2023.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ListCellStyle {
    
}

// MARK: - Rendering

extension ListCellStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(
                CornerBottomShape()
                    .fill(Color.red)
            )
    }
}

extension ListCell {
    func style(_ style: ListCellStyle) -> some View {
        return self.modifier(style)
    }
}

// MARK: - Previews

struct ListCellStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        ListCell(title: "Title", subtitle: "Subtitle")
            .style(ListCellStyle())
    }
}

