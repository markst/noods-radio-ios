
internal protocol Then { }

extension Then where Self: Any {
  internal func `do`(_ block: (inout Self) throws -> Void) rethrows -> Self {
    var copy = self
    try block(&copy)
    return copy
  }
}
