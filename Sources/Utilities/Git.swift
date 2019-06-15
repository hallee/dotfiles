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

    static func setupGlobalGitignore() -> Promise<Void> {
        let globalGitignoreFile = Constants.home + "/.gitignore"
        let gitignore = """
            .DS_Store
            """.data(using: .utf8)

        return Promise<Void> { seal in
            🐚.run(command:
                ["git", "config", "--global",
                 "core.excludesfile", globalGitignoreFile]
            ) {
                FileManager.default.createFile(atPath: globalGitignoreFile,
                                               contents: gitignore,
                                               attributes: nil)
                seal.fulfill()
            }
        }
    }

}
