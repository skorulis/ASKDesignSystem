import SwiftUI
import UIKit


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
	public var uiImage: UIImage {
        return UIImage(named: rawValue, in: .workaround, with: nil)!
    }
    public var medium: some View {
        self.frame(width: 40, height: 40)
    }
    public var small: some View {
        self.frame(width: 24, height: 24)
    }
}
