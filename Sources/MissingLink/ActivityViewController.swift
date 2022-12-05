//  Created by Alexander Skorulis on 15/10/2022.

import UIKit
import SwiftUI

public struct ActivityViewController: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?
    
    public init(activityItems: [Any],
                applicationActivities: [UIActivity]? = nil
    ) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
