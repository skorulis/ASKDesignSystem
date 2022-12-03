//Created by Alexander Skorulis on 3/12/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

public enum NavBarItem {
    
    case back(_ action: () -> Void)
    case close(_ action: () -> Void)
    case title(_ text: String)
    case iconButton(_ image: Image, () -> Void)
    
}

// MARK: - Rendering

extension NavBarItem: View {
    
    @ViewBuilder
    public var body: some View {
        switch self {
        case .back(let action):
            BackButton(action: action)
        case .close(let action):
            IconButton(action: action, image: Image(systemName: "xmark"))
        case .title(let text):
            title(text)
        case .iconButton(let image, let action):
            IconButton(action: action, image: image)
        }
    }
    
    private func title(_ text: String) -> some View {
        Text(text)
            .typography(.title)
            .foregroundColor(.primary)
    }
}

// MARK: - Inner types

private extension NavBarItem {
    
    struct BackButton: View {
        
        let action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        var body: some View {
            Button(action: back) {
                Image("chevron-left", bundle: .workaround)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
            .frame(width: 40, height: 40)
        }
        
        private func back() {
            action()
        }
    }
    
    struct IconButton: View {
        
        private let action: () -> Void
        private let image: Image
        
        init(action: @escaping () -> Void,
             image: Image
        ) {
            self.action = action
            self.image = image
        }
        
        var body: some View {
            Button(action: action) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
            }
            .frame(width: 40, height: 40)
        }
    }
}

// MARK: - Previews

struct NavBarItem_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            NavBarItem.back({})
            NavBarItem.title("Title")
        }
        
    }
}


