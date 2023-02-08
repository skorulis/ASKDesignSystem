//  Created by Alexander Skorulis on 24/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public struct NavBar<Left: View, Mid: View, Right: View> {
    
    private let left: Left
    private let mid: Mid
    private let right: Right
    
    public init(left: Left, mid: Mid, right: Right) {
        self.left = left
        self.mid = mid
        self.right = right
    }
    
}

extension NavBar where Left == NavBarItem, Mid == NavBarItem, Right == NavBarItem {
    public init(left: Left, mid: Mid, right: Right) {
        self.left = left
        self.mid = mid
        self.right = right
    }
}

extension NavBar where Mid == EmptyView, Right == EmptyView {
    
    public init(left: Left) {
        self.init(left: left, mid: EmptyView(), right: EmptyView())
    }
    
}

extension NavBar where Left == NavBarItem, Mid == EmptyView, Right == EmptyView {
    public init(left: NavBarItem) {
        self.init(left: left, mid: EmptyView(), right: EmptyView())
    }
}

extension NavBar where Left == EmptyView {
    public init(mid: Mid, right: Right) {
        self.init(left: EmptyView(), mid: mid, right: right)
    }
}

extension NavBar where Left == EmptyView, Mid == NavBarItem, Right == NavBarItem {
    
    public init(mid: NavBarItem, right: NavBarItem) {
        self.init(left: EmptyView(), mid: mid, right: right)
    }
}

extension NavBar where Left == EmptyView, Right == EmptyView {
    
    public init(mid: Mid) {
        self.init(left: EmptyView(), mid: mid, right: EmptyView())
    }
}

extension NavBar where Left == EmptyView, Mid == EmptyView {
    
    public init(right: Right) {
        self.init(left: EmptyView(), mid: EmptyView(), right: right)
    }
}

extension NavBar where Right == EmptyView {
    
    public init(left: Left, mid: Mid) {
        self.init(left: left, mid: mid, right: EmptyView())
    }
}

extension NavBar where Left == NavBarItem, Mid == NavBarItem, Right == EmptyView {
    public init(left: NavBarItem, mid: NavBarItem) {
        self.init(left: left, mid: mid, right: EmptyView())
    }
}

// MARK: - Rendering

extension NavBar: View {
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            items
                .frame(height: 44)
        }
        .foregroundColor(Color.ask.primary)
        .background(.ultraThinMaterial)
    }
    
    @ViewBuilder
    private var items: some View {
        if #available(iOS 16, *) {
            NavBarLayout {
                content
            }
        } else {
            HStack {
                content
            }
            .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        self.left
        Spacer(minLength: 8)
        self.mid
        Spacer(minLength: 8)
        self.right
    }
}

// MARK: - Previews

struct NavBar_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            NavBar(left: .back({}))
            
            NavBar(left: .back({}), mid: .title("Center me here"))
            
            NavBar(left: .back({}),
                   mid: .title("Center me here"),
                   right: .back({}))
            
            NavBar(left: NavBarItem.back({}),
                   mid: NavBarItem.title("Title here"),
                   right: Text("Right text"))
            
            NavBar(left: EmptyView(),
                   mid: Text("Center me here").multilineTextAlignment(.center),
                   right: Text("Right text that pushes"))
            
            NavBar(left: Text("Left text that pushes"),
                   mid: Text("Center me here").multilineTextAlignment(.center),
                   right: EmptyView())
            
            NavBar(left: Text("Left text that pushes"),
                   mid: Text("Center me here").multilineTextAlignment(.center),
                   right: Text("Right text that pushes"))
            
            Spacer()
        }
        
    }
}

