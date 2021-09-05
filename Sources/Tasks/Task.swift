import ArgumentParser

enum Task: String, CaseIterable, EnumerableFlag {

	case everything

	case apps
	case developer
	case git

	var description: String {
		switch self {
		case .everything: return "Bootstrapping everything..."
		case .apps: return "Installing apps..."
		case .developer: return "Setting up developer directory and tools..."
		case .git: return "Setting up Git..."
		}
	}

	var command: ParsableCommand.Type {
		switch self {
		case .everything: return Everything.self
		case .apps: return Apps.self
		case .developer: return Developer.self
		case .git: return Git.self
		}
	}

}

struct Everything: ParsableCommand {

	mutating func run() throws {
		print(Task.everything.description)

		try Task.allCases
			.filter { $0 != .everything }
			.forEach { task in
				var command = task.command.init()
				try command.run()
			}
	}

}
