import Foundation
import PromiseKit
import Shell

struct Git {

    static func clone(_ url: String) -> Promise<Void> {
        return Promise<Void> { seal in
            🐚.run(command: ["git", "clone", url]) {
                seal.fulfill()
            }
        }
    }

}
