import Foundation
import ConsoleKit
import PromiseKit

final class Bootstrap: Command {

    struct Signature: CommandSignature {}
    let signature: Signature = Signature()

    let help: String = "Bootstraps my development environment. 👨🏻‍🍳👌"

    lazy var bootstrapTasks: [Promise<Void>] = {
        [
//            Home.symlink(),
//            Fonts.install(),
//            iTerm.install(),
//            SublimeText.install(),
//            WebDevelopment.setup(),
            Icons.install()
        ]
    }()

    func run(using ctx: CommandContext<Bootstrap>) {
//        if ctx.console.confirm("Install all apps? (Takes awhile)") {
//            bootstrapTasks.append(Apps.install())
//        }

        Output.shared.console = ctx.console
        Output.shared.loadingBar("Bootstrapping...")

        when(resolved: bootstrapTasks).done { results in
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
