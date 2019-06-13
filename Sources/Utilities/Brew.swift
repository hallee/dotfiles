import Core

struct Brew {
    /// see https://github.com/vapor/toolbox/tree/master/Sources/Globals
    @discardableResult
    static func run(_ input: String) throws -> String {
        return try Process.execute("brew", input)
    }

}
