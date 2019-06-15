import Foundation
import PromiseKit

struct WebDevelopment {

    /// Installs Node, Vapor, and Yarn, and configures eslint (used by Sublime eslint plugin)
    static func setup() -> Promise<Void> {
        return firstly {
            Brew.run("brew", "install", "node", "vapor/tap/vapor", "yarn")
        }.then {
            Promise<Void> { seal in
                🐚.run(command: ["yarn", "global", "add", "eslint", "babel-eslint", "eslint-plugin-vue@next"]) {
                    seal.fulfill()
                }
            }
        }
    }

}
