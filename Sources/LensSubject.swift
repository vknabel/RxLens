import RxSwift

/// Enables reactive read and copy-on-write access for an entity's property in a datastructure.
/// Applies a given Lens to a subject.
public final class LensSubject<A, B>: SubjectType {
    public typealias E = B

    private var value: A
    private let lens: Lens<A, B>
    private let source: Observable<A>
    private let target: AnyObserver<A>
    /// Used in order to avoid multiple conversions and updated when having many subscribers.
    /// Uses unowned in order to break reference cycles.
    /// This code shall never be executed when not subscribed.
    private lazy var output: Observable<B> = self.source
        .do(onNext: { [unowned self] in self.value = $0 })
        .map({ [unowned self] in self.lens.from($0) })

    /// Creates a subject that describes only a property of a given data structure.
    ///
    /// - Parameter initial: The initial value to be used.
    /// - Parameter source: The observable that emits the data structure.
    /// - Parameter target: The observer for data structure.
    /// - Parameter lens: The lens for property access.
    public init<S: ObservableType, O: ObserverType>(initial: A, source: S, target: O, lens: Lens<A, B>) where S.E == A, O.E == A {
        self.value = initial
        self.lens = lens
        self.target = AnyObserver(target.asObserver())
        self.source = source.asObservable()
    }

    public func asObserver() -> AnyObserver<B> {
        return AnyObserver { event in
            switch event {
            case .next(let b):
                self.target.onNext(self.lens.to(b, self.value))
            case .error(let error):
                self.target.onError(error)
            case .completed:
                self.target.onCompleted()
            }
        }
    }

    public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == B {
        return asObservable().subscribe(observer)
    }

    public func asObservable() -> Observable<B> {
        return output
    }
}
