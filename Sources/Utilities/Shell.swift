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
            onStdout: { output in
                stdout?(output)
            }, onStderr: { error in
                stderr?(error)
            }, onCompletion: { result in
                completion()
            }
        )
    }

}
