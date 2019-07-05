import Foundation
import ConsoleKit
import PromiseKit

final class CustomizeIcons: Command {

    struct Signature: CommandSignature {}
    let signature: Signature = Signature()

    let help: String = "Customize application icons "

    lazy var tasks: [Promise<Void>] = {
        [
            Icons.install()
        ]
    }()

    func run(using context: CommandContext<CustomizeIcons>) throws {
        Output.shared.console = context.console
        Output.shared.loadingBar("Customizing icons...")

        when(resolved: tasks).done { results in
            try results.forEach { try $0.get() } // throw any errors

            Output.shared.stopLoading()
            Output.shared.print("Done.", style: .success, pop: false) {
                exit(EXIT_SUCCESS)
            }
        }.catch { error in
            fatalError(error.localizedDescription)
        }

        RunLoop.main.run()
    }
}
