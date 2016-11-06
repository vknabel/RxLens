import RxSwift

public extension LensSubject {
    /// Creates a subject that describes only a property of a given data structure.
    ///
    /// - Parameter initial: The initial value to be used.
    /// - Parameter subject: The subject that will be lensed.
    /// - Parameter lens: The lens for property access.
    public convenience init<S: SubjectType>(initial: A, subject: S, lens: Lens<A, B>) where S.SubjectObserverType.E == A, S.E == A {
        self.init(initial: initial, source: subject.asObservable(), target: AnyObserver(subject.asObserver()), lens: lens)
    }

    /// Creates a subject that describes only a property of a given data structure.
    ///
    /// - Parameter subject: The behavior subject that will be lensed. The current value will be used initially.
    /// - Parameter lens: The lens for property access.
    public convenience init(subject: BehaviorSubject<A>, lens: Lens<A, B>) throws {
        try self.init(initial: subject.value(), source: subject.asObservable(), target: AnyObserver(subject.asObserver()), lens: lens)
    }
}
