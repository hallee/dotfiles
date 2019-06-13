import Foundation
import ConsoleKit
import PromiseKit
import Shell

final class Bootstrap: Command {

    struct Signature: CommandSignature {}
    let signature: Signature = Signature()

    let help: String = "Bootstraps my development environment. 👨🏻‍🍳👌"
     var bootstrapTasks: [Promise<Void>] {
         return [
             Apps.install(),
             Fonts.install()
         ]
     }

    func run(using ctx: CommandContext<Bootstrap>) throws {
        ctx.console.output("Perfection 👨🏻‍🍳👌", style: .plain)
        let loadingBar = ctx.console.loadingBar(title: "Bootstrapping")
        loadingBar.start()

        firstly {
            when(fulfilled: bootstrapTasks)
        }.ensure {
            loadingBar.succeed()
        }.catch { error in
            fatalError(error.localizedDescription)
        }

        RunLoop.main.run()
    }
}
