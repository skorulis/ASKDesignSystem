//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct PageTemplate<Nav: View, Content: View> {
    
    private let nav: () -> Nav
    private let content: () -> Content
    
    public init(nav: @escaping () -> Nav, content: @escaping () -> Content) {
        self.nav = nav
        self.content = content
    }
    
}

// MARK: - Rendering

extension PageTemplate: View {
    
    public var body: some View {
        ZStack {
            NavViewBackground()
                .ignoresSafeArea()
            foregroundContent
        }
#if os(iOS)
        .navigationBarHidden(true)
#endif
    }
    
    private var foregroundContent: some View {
        VStack(spacing: -10) {
            nav()
                .zIndex(2)
            ScrollView {
                Spacer()
                    .frame(height: 22)
                content()
            }
            .background(Color.ask.background)
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Previews

struct PageTemplate_Previews: PreviewProvider {
    
    static var previews: some View {
        PageTemplate {
            NavBar(left: .back({}), mid: .title("Title"))
        } content: {
            VStack(spacing: 2) {
                ForEach(0..<100) { index in
                    Text("TEst \(index)")
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        
                }
            }
        }

    }
}



