import PromiseKit
import Shell

struct Brew {

    static func run(_ command: String...) -> Promise<Void> {
        return Promise<Void> { seal in
            Shell().async(
                ["/usr/local/bin/brew"] + command,
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

}
