import Foundation
import PromiseKit

struct Home {

    static func symlink() -> Promise<Void> {
        let executableURL = URL(fileURLWithPath: (Bundle.main.executablePath ?? ""))
        let dotfilesDirectoryURL = executableURL.deletingLastPathComponent().appendingPathComponent("Home")

        return Promise<Void> { seal in
            Output.shared.print(Bundle.main.executablePath!)
            let searcher = FileManager.default.enumerator(
                at: dotfilesDirectoryURL,
                includingPropertiesForKeys: nil,
                options: [.skipsPackageDescendants]
            )
            while let file = searcher?.nextObject() as? URL {
                guard !file.hasDirectoryPath else { continue }
                guard file.lastPathComponent != ".DS_Store" else { continue }

                var relativeFileComponents = file.pathComponents
                for component in dotfilesDirectoryURL.pathComponents {
                    if let index = relativeFileComponents.firstIndex(where: {$0 == component}) {
                        relativeFileComponents.remove(at: index)
                    }
                }
                let relativeFilePathComponent = relativeFileComponents.joined(separator: "/")
                let destination = Constants.home.appendingPathComponent(relativeFilePathComponent)

                try? FileManager.default.removeItem(at: destination)
                try FileManager.default.createSymbolicLink(
                    at: destination,
                    withDestinationURL: file
                )
            }
            seal.fulfill()
        }
    }

}
