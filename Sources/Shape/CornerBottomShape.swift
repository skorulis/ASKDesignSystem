//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

struct CornerBottomShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midY = rect.height / 2
        let edgePadding: CGFloat = 30
        path.move(to: .zero)
        path.addLine(to: .init(x: rect.width, y: 0))
        path.addLine(to: .init(x: rect.width + midY, y: midY))
        path.addQuadCurve(
            to: CGPoint(x: rect.width - edgePadding, y: rect.height),
            control: CGPoint(x: rect.width, y: rect.height)
        )
        path.addLine(to: CGPoint(x: edgePadding, y: rect.height))
        
        path.addQuadCurve(
            to: CGPoint(x: -midY, y: midY),
            control: CGPoint(x: 0, y: rect.height)
        )
        
        path.addLine(to: .zero)
        return path
    }
    
}

struct CornerBottomShape_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            CornerBottomShape()
                .fill(Color.blue)
                .frame(height: 44)
            
            CornerBottomShape()
                .fill(Color.blue)
                .frame(height: 44)
                .padding(40)
        }
    }
    
}
