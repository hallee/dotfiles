enum Brew {

	static func install(_ packages: String..., cask: Bool = false) throws {
		try install(packages, cask: cask)
	}

	static func install(_ packages: [String], cask: Bool = false) throws {
		var args = packages
		if cask {
			args.insert("--cask", at: 0)
		}
		args.insert("install", at: 0)
		try Shell.run("brew", args)
	}

}
