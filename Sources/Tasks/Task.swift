import ArgumentParser

enum Task: String, CaseIterable, EnumerableFlag {

	case everything

	case apps
	case developer
	case fonts
	case git
	case preferences
	case tools

	var description: String {
		switch self {
		case .everything: return "Bootstrapping everything..."
		case .apps: return "Installing apps..."
		case .developer: return "Setting up developer directory and tools..."
		case .fonts: return "Installing fonts..."
		case .git: return "Setting up Git..."
		case .preferences: return "Setting preferences..."
		case .tools: return "Setting up tools..."
		}
	}

	var command: ParsableCommand.Type {
		switch self {
		case .everything: return Everything.self
		case .apps: return Apps.self
		case .developer: return Developer.self
		case .fonts: return Fonts.self
		case .git: return Git.self
		case .preferences: return Preferences.self
		case .tools: return Tools.self
		}
	}

}

struct Everything: ParsableCommand {

	mutating func run() throws {
		print(Task.everything.description)

		Task.allCases
			.filter { $0 != .everything }
			.forEach { task in
				task.command.main([])
			}
	}

}
