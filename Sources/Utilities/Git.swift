import Foundation
import PromiseKit
import Shell

struct Git {

    static func clone(_ url: String) -> Promise<Void> {
        return Promise<Void> { seal in
            🐚.run(
                command: ["git", "clone", url],
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
