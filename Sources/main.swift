import Foundation
import ConsoleKit
import Shell

final class Main: CommandGroup {

    struct Signature: CommandSignature {}
    let signature: Signature = Signature()

    let commands: Commands = [
        "bootstrap": Bootstrap()
    ]

    let help: String = "My dotfiles."

    func run(using ctx: CommandContext<Main>) throws {
        ctx.console.output("👋 use `dotfiles -h` to see commands", style: .plain)
        var input = CommandInput(arguments: CommandLine.arguments)
        try ctx.console.run(Bootstrap(), input: &input)
    }
}

public func run() throws {
    var input = CommandInput(arguments: CommandLine.arguments)
    try Terminal().run(Main(), input: &input)
}

try run()
