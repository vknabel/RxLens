import RxSwift

public extension ObservableType {
    /// Accesses a given property of the streamed data structure.
    ///
    /// - Parameter lens: The lens to be used for data access.
    /// - Returns: An observable that returns a given property of the streamed data structure.
    public func from<T>(_ lens: Lens<E, T>) -> Observable<T> {
        return self.map(lens.from)
    }
}

public extension ObserverType {
    /// Access a given property of the received data structre.
    ///
    /// - Parameter lens: The lens to be used for data access.
    /// - Returns: An observer for a property of the current data structure.
    public func to<T>(_ lens: Lens<E, T>, with initial: E) -> AnyObserver<T> {
        var data: E = initial
        return AnyObserver<T> { (event) in
            switch event {
            case let .next(property):
                data = lens.to(property, data)
                self.onNext(data)
            case let .error(e):
                self.onError(e)
            case .completed():
                self.onCompleted()
            }
        }
    }
}
