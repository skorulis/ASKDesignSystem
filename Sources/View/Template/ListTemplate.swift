//Created by Alexander Skorulis on 4/12/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct ListTemplate<Nav: View, Content: View> {
    
    private let nav: () -> Nav
    private let content: () -> Content
    
    public init(nav: @escaping () -> Nav, content: @escaping () -> Content) {
        self.nav = nav
        self.content = content
    }
    
}

// MARK: - Rendering

extension ListTemplate: View {
    
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
            List {
                Color.ask.background
                    .frame(height: 2)
                    .listRowSeparator(.hidden)
                content()
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 10)
        }
        .background(Color.ask.background)
    }
}

private struct ExtendedBottomRectangleShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: .init(x: rect.width, y: 0))
        path.addLine(to: .init(x: rect.width, y: rect.height + 80))
        path.addLine(to: .init(x: 0, y: rect.height + 80))
        path.addLine(to: .zero)
        return path
    }
    
}


// MARK: - Previews

struct ListTemplate_Previews: PreviewProvider {
    
    static var previews: some View {
        ListTemplate {
            NavBar(left: .back({}))
        } content: {
            ForEach(0..<30) { i in
                Text("TEst \(i)")
            }
        }

    }
}



