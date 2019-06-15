import Foundation
import Shell

struct 🐚 {

    static func run(command: [String],
                    stdout: ((String) -> Void)? = nil,
                    stderr: ((String) -> Void)? = nil,
                    completion: @escaping () -> Void) {
        Shell().async(
            command,
            shouldBeTerminatedOnParentExit: true,
            workingDirectoryPath: nil,
            env: nil,
            onStdout: { stdout?($0) },
            onStderr: { stderr?($0) },
            onCompletion: { _ in
                completion()
            }
        )
    }

}
