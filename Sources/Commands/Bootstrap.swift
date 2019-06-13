import Foundation
import ConsoleKit

final class Bootstrap: Command {
    let workQueue = DispatchQueue(label: "dotfiles")
    struct Signature: CommandSignature {}

    let signature: Signature = Signature()

    let help: String = "Bootstraps my development environment. 👨🏻‍🍳👌"

    func run(using ctx: CommandContext<Bootstrap>) throws {
        ctx.console.output("Perfection 👨🏻‍🍳👌", style: .plain)
        let loadingBar = ctx.console.loadingBar(title: "Test", targetQueue: workQueue)
        workQueue.asyncAfter(deadline: .now() + 2) {
            print("TEST")
            loadingBar.succeed()
        }
        loadingBar.start()
        ctx.console.wait(seconds: 5)
    }
}
