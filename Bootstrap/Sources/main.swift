import Foundation
import ConsoleKit

func setup() {
    let home = FileManager.default.homeDirectoryForCurrentUser

    Apps.install(home)
    Fonts.install(home)
}

setup()
