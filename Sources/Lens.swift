/// Enables read and copy-on-write access for an entity's property in a datastructure.
///
/// Some examples can be found in this [blog post](http://chris.eidhof.nl/post/lenses-in-swift/).
public struct Lens<A, B> {
    /// Serves as getter.
    public let from: (A) -> B
    /// Serves as setter.
    public let to: (B, A) -> A

    /// Creates a lens.
    ///
    /// - Parameter from: Returns a property from a given value.
    /// - Parameter of: Sets a property to a given value.
    public init(from: @escaping (A) -> B, to: @escaping (B, A) -> A) {
        self.from = from
        self.to = to
    }
}
