import Foundation
import ConsoleKit
import PromiseKit
import Shell

final class Bootstrap: Command {

    struct Signature: CommandSignature {}
    let signature: Signature = Signature()

    let help: String = "Bootstraps my development environment. 👨🏻‍🍳👌"

    func bootstrapTasks(_ console: Console) throws -> [Promise<Void>] {
         return [
             Apps.install(),
             Fonts.install()
         ]
     }

    func run(using ctx: CommandContext<Bootstrap>) throws {
        Output.shared.console = ctx.console
        Output.shared.loadingBar("Bootstrapping...")

        firstly {
            when(fulfilled: try bootstrapTasks(ctx.console))
        }.ensure {
            Output.shared.stopLoading()
            Output.shared.print("Perfection 👨🏻‍🍳👌", style: .success, pop: false) {
                exit(EXIT_SUCCESS)
            }
        }.catch { error in
            fatalError(error.localizedDescription)
        }

        RunLoop.main.run()
    }
}
