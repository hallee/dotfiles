import Foundation
import PromiseKit
import Shell

struct 🐚 {

    static func run(command: [String],
                    stdout: ((String) -> Void)? = nil,
                    stderr: ((String) -> Void)? = nil,
                    resolver: Resolver<Void>) {
        Shell().async(
            command,
            shouldBeTerminatedOnParentExit: true,
            workingDirectoryPath: nil,
            env: nil,
            onStdout: { stdout?($0) },
            onStderr: { stderr?($0) },
            onCompletion: { result in
                switch result {
                case .success: resolver.fulfill()
                case .failure(let error): resolver.reject(error)
                }
            }
        )
    }

}
