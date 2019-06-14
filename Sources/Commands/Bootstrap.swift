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
//             Apps.install(console),
             try Fonts.install()
         ]
     }

    func run(using ctx: CommandContext<Bootstrap>) throws {
        ctx.console.output("Perfection 👨🏻‍🍳👌", style: .plain)
        ctx.console.pushEphemeral()
//        let loadingBar = ctx.console.loadingBar(title: "Bootstrapping")
//        loadingBar.start()

        firstly {
            when(fulfilled: try bootstrapTasks(ctx.console))
        }.ensure {
//            loadingBar.succeed()
            print("DONE")
        }.catch { error in
            fatalError(error.localizedDescription)
        }

        RunLoop.main.run()
    }
}
