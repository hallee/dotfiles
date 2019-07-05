import Foundation
import ConsoleKit
import PromiseKit
#if canImport(AppKit)
import AppKit
#endif

struct Icons {

    static func install() -> Promise<Void> {
        #if canImport(AppKit)
        #else
        return Promise<Void> { seal in seal.fulfill() }
        #endif
    }

}
