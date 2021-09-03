import ArgumentParser

struct Dotfiles: ParsableCommand {

	@Flag
	var task: [Task] = Task.allCases

	mutating func run() throws {
		print("Setting things up:")
		for task in task {
			try task.run()
		}
	}

}

Dotfiles.main()
