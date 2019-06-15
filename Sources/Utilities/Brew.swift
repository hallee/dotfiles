import Foundation
import PromiseKit

struct Brew {

    static func run(_ command: String...) -> Promise<Void> {
        run(command)
    }

    private static func run(_ commands: [String]) -> Promise<Void> {
        return Promise<Void> { seal in
            🐚.run(
                command: ["/usr/local/bin/brew"] + commands,
                stdout: { Output.shared.print($0) },
                stderr: { Output.shared.print($0, style: .error) }
            ) {
                seal.fulfill()
            }
        }
    }

    static func cask(_ apps: [String]) -> Promise<Void> {
        let tasks = apps.map { run("cask", "reinstall", $0) }
        return when(fulfilled: tasks)
    }

}
