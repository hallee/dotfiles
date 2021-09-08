import ArgumentParser

@main
struct Dotfiles: ParsableCommand {

	static let interruptMonitor = Shell.monitorInterrupt()

	static var configuration = CommandConfiguration(
		abstract: "Dotfiles: for setting up preferences, utilities, fonts, and apps on a new macOS computer.",
		subcommands: [Bootstrap.self],
		defaultSubcommand: Bootstrap.self
	)

}

extension Dotfiles {

	struct Bootstrap: ParsableCommand {

		static var configuration = CommandConfiguration(
			abstract: "Bootstrap various preferences, utilities, fonts, and apps.",
			subcommands: Task.allCases.map { $0.command },
			defaultSubcommand: Task.everything.command
		)

	}

}
