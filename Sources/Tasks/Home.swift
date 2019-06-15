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
                options: [.skipsPackageDescendants,
                          .skipsSubdirectoryDescendants]
            )
            while let file = searcher?.nextObject() as? URL {
                let destination = Constants.home.appendingPathComponent(file.lastPathComponent)
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
