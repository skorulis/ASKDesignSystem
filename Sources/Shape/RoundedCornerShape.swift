//Created by Alexander Skorulis on 16/3/2023.

import Foundation
import SwiftUI

public struct RectCorner: OptionSet, Sendable {
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
        
    public static let topLeft = RectCorner(rawValue: 1 << 0)
    public static let topRight = RectCorner(rawValue: 1 << 1)
    public static let bottomRight = RectCorner(rawValue: 1 << 2)
    public static let bottomLeft = RectCorner(rawValue: 1 << 3)
    
    public static let allCorners: RectCorner = [.topLeft, topRight, .bottomLeft, .bottomRight]
}

// draws shape with specified rounded corners applying corner radius
public struct RoundedCornersShape: Shape {
    
    private let radius: CGFloat
    private let corners: RectCorner
    
    public init(radius: CGFloat, corners: RectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        var path = Path()

        let p1 = CGPoint(x: rect.minX, y: corners.contains(.topLeft) ? rect.minY + radius  : rect.minY )
        let p2 = CGPoint(x: corners.contains(.topLeft) ? rect.minX + radius : rect.minX, y: rect.minY )

        let p3 = CGPoint(x: corners.contains(.topRight) ? rect.maxX - radius : rect.maxX, y: rect.minY )
        let p4 = CGPoint(x: rect.maxX, y: corners.contains(.topRight) ? rect.minY + radius  : rect.minY )

        let p5 = CGPoint(x: rect.maxX, y: corners.contains(.bottomRight) ? rect.maxY - radius : rect.maxY )
        let p6 = CGPoint(x: corners.contains(.bottomRight) ? rect.maxX - radius : rect.maxX, y: rect.maxY )

        let p7 = CGPoint(x: corners.contains(.bottomLeft) ? rect.minX + radius : rect.minX, y: rect.maxY )
        let p8 = CGPoint(x: rect.minX, y: corners.contains(.bottomLeft) ? rect.maxY - radius : rect.maxY )

        
        path.move(to: p1)
        path.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.minY),
                    tangent2End: p2,
                    radius: radius)
        path.addLine(to: p3)
        path.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.minY),
                    tangent2End: p4,
                    radius: radius)
        path.addLine(to: p5)
        path.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.maxY),
                    tangent2End: p6,
                    radius: radius)
        path.addLine(to: p7)
        path.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.maxY),
                    tangent2End: p8,
                    radius: radius)
        path.closeSubpath()

        return path
    }
}

struct RoundedCornerShape_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            RoundedCornersShape(radius: 10, corners: [.bottomRight, .bottomLeft])
                .fill(Color.blue)
                .frame(height: 44)
            
            RoundedCornersShape(radius: 10, corners: [.topRight, .bottomLeft])
                .fill(Color.blue)
                .frame(height: 44)
                .padding(40)
        }
    }
    
}
