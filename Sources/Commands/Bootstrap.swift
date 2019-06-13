import Foundation
import ConsoleKit
import PromiseKit
import Shell

final class Bootstrap: Command {

    struct Signature: CommandSignature {}
    let signature: Signature = Signature()

    let help: String = "Bootstraps my development environment. 👨🏻‍🍳👌"

    func bootstrapTasks(_ console: Console) -> [Promise<Void>] {
         return [
             Apps.install(console),
             Fonts.install()
         ]
     }

    func run(using ctx: CommandContext<Bootstrap>) throws {
        ctx.console.output("Perfection 👨🏻‍🍳👌", style: .plain)
        ctx.console.pushEphemeral()
        let loadingBar = ctx.console.loadingBar(title: "Bootstrapping")
        loadingBar.start()

        firstly {
            when(fulfilled: bootstrapTasks(ctx.console))
        }.ensure {
            loadingBar.succeed()
        }.catch { error in
            fatalError(error.localizedDescription)
        }

        RunLoop.main.run()
    }
}
