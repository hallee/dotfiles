import Foundation
import PromiseKit

struct Apps {
    private static let queue = DispatchQueue(label: "dotfiles-apps")

    static func install() -> Promise<Void> {
        return Brew.run("doctor")
    }

}
