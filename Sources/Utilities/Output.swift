import Foundation
import ConsoleKit

final class Output {

    static let shared = Output()
    private init() { }

    weak var console: Console?

    private var loadingBar: ActivityIndicator<LoadingBar>?

    private let queue = DispatchQueue(label: "ConsoleOutputQueue")

    func print(_ string: String,
               style: ConsoleStyle = .plain,
               pop: Bool = true,
               completion: (() -> Void)? = nil) {
        queue.async { [weak self] in
            if pop { self?.console?.popEphemeral() }
            self?.console?.output(string, style: style)
            self?.console?.pushEphemeral()
            completion?()
        }
    }

    func loadingBar(_ string: String) {
        queue.async { [weak self] in
            self?.console?.pushEphemeral()
            self?.loadingBar = self?.console?.loadingBar(title: string,
                                                         targetQueue: self?.queue)
            self?.loadingBar?.start(refreshRate: 20)
            self?.console?.pushEphemeral()
        }
    }

    func stopLoading() {
        loadingBar?.succeed()
    }

}
