//
//  Lens+Children.swift
//  RxLens
//
//  Created by Valentin Knabel on 15.11.16.
//  Copyright © 2016 Valentin Knabel. All rights reserved.
//

public extension Lens {
    /// Creates a new lens by using a child lens.
    ///
    /// - Parameter lens: The lens to be used as child of `self`.
    /// - Returns: A new lens from the current type to the given.
    public func child<C>(with lens: Lens<B, C>) -> Lens<A, C> {
        return Lens<A, C>(
            from: { lens.from(self.from($0)) },
            to: { (c: C, a: A) -> A in
                let b: B = lens.to(c, self.from(a))
                return self.to(b, a) as A
            }
        )
    }

    /// Creates a new lens by using a child lens.
    /// Convenience method for `Lens.child(lens:)`.
    ///
    /// - Parameter from: `Lens.from` to be used as a child-
    /// - Parameter to: `Lens.to` to be used as a child-
    /// - Returns: A new lens from the current type to the given.
    public func child<C>(from: @escaping (B) -> C, to: @escaping (C, B) -> B) -> Lens<A, C> {
        return self.child(with: Lens<B, C>(from: from, to: to))
    }

    /// Creates a new lens by using a child lens.
    /// Reversed convenience method for `Lens.child(lens:)`.
    ///
    /// - Parameter lens: The lens to be used as parent of `self`.
    /// - Returns: A new, combined lens.
    public func asChild<S>(of parent: Lens<S, A>) -> Lens<S, B> {
        return parent.child(from: from, to: to)
    }
    /// Creates a new lens by using a child lens.
    /// Reversed convenience method for `Lens.child(lens:)`.
    ///
    /// - Parameter lens: The lens to be used as parent of `self`.
    /// - Returns: A new, combined lens.
    public func asChild<S>(from: @escaping (S) -> A, to: @escaping (A, S) -> S) -> Lens<S, B> {
        return asChild(of: Lens<S, A>(from: from, to: to))
    }
}
