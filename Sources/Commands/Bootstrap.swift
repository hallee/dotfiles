import Foundation
import ConsoleKit
import PromiseKit
import Shell

final class Bootstrap: Command {

    struct Signature: CommandSignature {}
    let signature: Signature = Signature()

    let help: String = "Bootstraps my development environment. 👨🏻‍🍳👌"

    func bootstrapTasks() -> [Promise<Void>] {
         return [
//             Apps.install(),
             Fonts.install(),
             SublimeText.install()
         ]
     }

    func run(using ctx: CommandContext<Bootstrap>) {
        Output.shared.console = ctx.console
        Output.shared.loadingBar("Bootstrapping...")


        when(resolved: bootstrapTasks()).done { results in
            try results.forEach { try $0.get() } // throw any errors

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
