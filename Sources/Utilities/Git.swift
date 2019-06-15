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

    static func setupGlobalGit() -> Promise<Void> {
        return Promise<Void> { seal in
            🐚.run(command:
                ["git", "config", "--global",
                 "core.excludesfile", Constants.globalGitignorePath]
            ) {
                FileManager.default.createFile(
                    atPath: Constants.globalGitignorePath,
                    contents: Constants.globalGitignore.data(using: .utf8),
                    attributes: nil)
                🐚.run(command:
                    ["git", "config", "--global",
                     "user.name", Constants.globalGitName]
                ) {
                    🐚.run(command:
                        ["git", "config", "--global",
                         "user.email", Constants.globalGitEmail]
                    ) {
                        seal.fulfill()
                    }
                }
            }
        }
    }

}
