import Foundation
import ConsoleKit

final class Main: CommandGroup {

    struct Signature: CommandSignature {}
    let signature: Signature = Signature()

    let commands: [String : AnyCommand] = [
        "bootstrap": Bootstrap(),
        "app-icons": CustomizeIcons()
    ]

    let help: String = "My dotfiles."

    func run(using ctx: CommandContext) throws {
        ctx.console.output("👋 use `dotfiles -h` to see commands", style: .plain)
    }
}

public func run() throws {
    let input = CommandInput(arguments: CommandLine.arguments)
    try Terminal().run(Main(), input: input)
}

try run()
