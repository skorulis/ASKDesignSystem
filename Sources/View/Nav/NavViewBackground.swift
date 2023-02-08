//  Created by Alexander Skorulis on 22/1/2023.

import Foundation

import SwiftUI

// MARK: - Memory footprint

struct NavViewBackground {
    
}

// MARK: - Rendering

extension NavViewBackground: View {
    
    var body: some View {
        VStack(spacing: 0) {
            Color.clear
                .background(.ultraThinMaterial)
                .frame(height: 60)
            
            Color.white
        }
    }
}

// MARK: - Previews

struct NavViewBackground_Previews: PreviewProvider {
    
    static var previews: some View {
        NavViewBackground()
            .ignoresSafeArea()
    }
}

