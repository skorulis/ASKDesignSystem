//  Created by Alexander Skorulis on 15/8/2022.

import Foundation
import SwiftUI

public struct NavBarLayoutResult {
    let containerSize: CGSize
    let subviewPositions: [CGPoint]
}

@available(iOS 16, *)
struct NavBarLayout: Layout {
    func makeCache(subviews: Subviews) -> NavBarLayoutResult {
        return NavBarLayoutResult(containerSize: .zero, subviewPositions: [])
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout NavBarLayoutResult) -> CGSize {
        return proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout NavBarLayoutResult) {
        if bounds.width == 0 {
            return
        }
        var remainingWidth = bounds.size.width
        var viewPosition = 0
        var leftPadding: CGFloat = 0
        var rightPadding: CGFloat = 0
        
        var middleView: LayoutSubview?
        
        for sub in subviews {
            let minSize = sub.sizeThatFits(.unspecified)
            let maxSize = sub.sizeThatFits(proposal)
            let isSpacer = minSize.width == 8 && maxSize.width == proposal.width
            
            let yPos = bounds.minY + (bounds.size.height - minSize.height) / 2
            let size = ProposedViewSize(width: minSize.width, height: bounds.height)
            
            if isSpacer {
                viewPosition += 1
                continue
            }
            
            if viewPosition == 0 {
                sub.place(at: CGPoint(x: 0, y: yPos), proposal: size)
                leftPadding = minSize.width
            } else if viewPosition == 1 {
                middleView = sub
                
            } else if viewPosition == 2 {
                sub.place(at: CGPoint(x: bounds.width - minSize.width, y: yPos), proposal: size)
                rightPadding = minSize.width
            }
            
            remainingWidth -= minSize.width

        }
        
        if let middleView {
            let availableSize = bounds.size.width - leftPadding - rightPadding
            var minSize = middleView.sizeThatFits(.unspecified)
            minSize.width = min(minSize.width, availableSize)
            
            var x = (bounds.width - minSize.width)/2
            if x < leftPadding {
                x = leftPadding
            }
            
            let maxX = bounds.size.width - rightPadding - minSize.width
            x = min(x, maxX)
            
            
            let yPos = bounds.minY + (bounds.size.height - minSize.height) / 2
            let size = ProposedViewSize(width: minSize.width, height: bounds.height)
            middleView.place(at: CGPoint(x: x, y: yPos), proposal: size)
        }
        
    }
    
}

@available(iOS 16, *)
struct NavBarLayout_Previews: PreviewProvider {
    
    static var previews: some View {
        NavBarLayout {
            Text("TEST")
        }
    }
}
