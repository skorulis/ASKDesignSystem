//Created by Alexander Skorulis on 3/12/2022.

import Foundation

private class BundleFinder {}

internal extension Bundle {
    static var workaround: Bundle = {
        return Bundle(for: BundleFinder.self).workaround(name: "ASKDesignSystem")
    }()
}

public extension Bundle {
    
    func workaround(name: String) -> Bundle {
        let candidates = [
            Bundle.main.resourceURL,
            self.resourceURL,
            self.resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
            self.resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent()
            
        ].compactMap { $0 }
        
        for can in candidates {
            let paths = [
                can.appending(path: "LocalPackages_\(name).bundle"), // iOS
                can.appending(path: "\(name)_\(name).bundle") // Mac
            ]
            for path in paths {
                if let bundle = Bundle.init(url: path) {
                    return bundle
                }
            }
        }
        fatalError("Could not find workout bundle for \(name)")
    }
    
}
