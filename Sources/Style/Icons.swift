import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public enum ASKIcon: String {
	case chevronLeft = "chevron-left"
}

extension ASKIcon: View {
	public var body: some View {
        baseImage
            .resizable()
            .aspectRatio(contentMode: .fit)
	}
    public func image(_ size: CGFloat) -> some View {
        baseImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
    }
    public var baseImage: Image {
        Image(self.rawValue, bundle: .workaround)
    }
	
    public var medium: some View {
        self.frame(width: 40, height: 40)
    }
    public var small: some View {
        self.frame(width: 24, height: 24)
    }
#if canImport(UIKit)
    public var uiImage: NativeImage {
        return NativeImage(named: rawValue, in: .workaround, with: nil)!
    }
#endif
}
