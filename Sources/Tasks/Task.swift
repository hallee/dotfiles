import ArgumentParser

enum Task: String, CaseIterable, EnumerableFlag {
	case apps
	case developer
	case git

	var description: String {
		switch self {
		case .apps: return "Installing apps..."
		case .developer: return "Setting up developer directory and tools..."
		case .git: return "Setting up Git..."
		}
	}

	func run() throws {
		print("\n\(description)")
		switch self {
		case .apps:
			try Apps.install()
		case .developer:
			try Developer.setup()
		case .git:
			try Git.setup()
		}
	}
}
