import Foundation
import PromiseKit
import Shell

struct Brew {

    static func run(_ command: String...) -> Promise<Void> {
        run(command)
    }

    private static func run(_ commands: [String]) -> Promise<Void> {
        return Promise<Void> { seal in
            Shell().async(
                ["/usr/local/bin/brew"] + commands,
                shouldBeTerminatedOnParentExit: false,
                workingDirectoryPath: nil,
                env: nil,
                onStdout: { output in
                    print(output)
                }, onStderr: { error in
                    print(error)
                }, onCompletion: { result in
                    seal.fulfill()
                }
            )
        }
    }

    static func cask(_ apps: [String]) -> Promise<Void> {
        let tasks = apps.map { run("cask", "reinstall", $0) }
        return when(fulfilled: tasks)
    }

}
