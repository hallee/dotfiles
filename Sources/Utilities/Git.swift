import Foundation
import PromiseKit

struct Git {

    static func clone(_ url: String, into: String? = nil) -> Promise<Void> {
        return Promise<Void> { seal in
            🐚.run(
                command: ["git", "clone", url, into ?? ""],
                stdout: { output in
                    Output.shared.print(output)
                },
                stderr: { error in
                    Output.shared.print(error, style: .error)
                }
            ) {
                seal.fulfill()
            }
        }
    }

}
