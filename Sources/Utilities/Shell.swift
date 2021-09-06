import Foundation

enum Shell {

	private static var runningProcesses = [Process]()

	private static let processQueue = DispatchQueue(label: "shell-process-queue")
	private static let waitQueue = DispatchQueue(label: "shell-wait-queue")

	static func run(_ command: String, _ arguments: [String]) throws {
		let process = Process()
		process.launchPath = "/bin/zsh"
		process.arguments = ["-c", command + " " + arguments.joined(separator: " ")]

		let standardError = Pipe()
		process.standardError = standardError
		process.standardInput = FileHandle.nullDevice

		var errorData = Data()

		standardError.fileHandleForReading.readabilityHandler = { handler in
			let data = handler.availableData
			processQueue.async { errorData.append(data) }
		}

		try process.run()
		processQueue.async { self.runningProcesses.append(process) }
		process.waitUntilExit()
		processQueue.async { self.runningProcesses.removeAll(where: { $0 == process }) }

		if process.terminationStatus != 0 {
			throw ShellError.standardError(String(data: errorData, encoding: .utf8))
		}
	}

	static func run(_ command: String, _ arguments: String...) throws {
		try run(command, arguments)
	}

	static func monitorInterrupt() -> DispatchSourceSignal {
		signal(SIGINT, SIG_IGN)
		let sigintSrc = DispatchSource.makeSignalSource(signal: SIGINT, queue: .main)
		sigintSrc.setEventHandler {
			Shell.interrupt()
			exit(130)
		}
		sigintSrc.resume()
		return sigintSrc
	}

	static func interrupt() {
		runningProcesses.forEach {
			$0.interrupt()
		}
	}

	static func terminate() {
		runningProcesses.forEach {
			$0.terminate()
		}
	}

}

enum ShellError: LocalizedError {

	case standardError(String?)

	var errorDescription: String? {
		if case let .standardError(description) = self {
			return description
		}
		return "An unknown error occurred."
	}

}
