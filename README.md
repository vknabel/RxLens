[![CocoaPods](https://img.shields.io/cocoapods/v/RxLens.svg?maxAge=2592000&style=flat-square)]()
[![CocoaPods](https://img.shields.io/cocoapods/p/RxLens.svg?maxAge=2592000&style=flat-square)]()
[![Install](https://img.shields.io/badge/install-SwiftPM%20%7C%20Cocoapods-lightgrey.svg?style=flat-square)]()
[![License](https://img.shields.io/cocoapods/l/RxLens.svg?maxAge=2592000&style=flat-square)]()

# RxLens

Enables reactive read and copy-on-write access for an entity's property in a data structure.

Check out the generated docs at [vknabel.github.io/RxLens](https://vknabel.github.io/RxLens/).

## Introduction

First we need to declare our data structure and an according lens for our property.
An explanation for lenses can be found in this [blog post](http://chris.eidhof.nl/post/lenses-in-swift/) of Chris Eidhof.

```swift
struct Person: Equatable {
    let name: String

    static var name: Lens<Person, String> {
        return Lens(
            from: { $0.name },
            to: { name, _ in Person(name: name) }
        )
    }
}
```

### Lens Subject

You may create a subject that will only reflect changes of the name and allows pushing new names.

```swift
let personBehavior = BehaviorSubject(value: Person(name: "Valentin Knabel"))
let nameSubject = LensSubject(subject: personBehavior, lens: Person.name)
```

### Operators

The following operators will be defined by using the following subject.

```swift
let personSubject = PublishSubject<Person>()
```

First of all you can use your lenses in order to access properties of your data structure with `Observable.from(_:)`.

```swift
let nameSubject = personSubject.asObservable().from(Person.name)
```

Additionally you can use `Observer.to(_:, with:)` in order to only observe changes of your property.

```swift
let nameObserver = personSubject.asObserver().to(Person.name, with: Person(name: "Initial"))
```

## Installation

RxLens is a Swift only project and supports [Swift Package Manager](https://github.com/apple/swift-package-manager) and [CocoaPods](https://github.com/CocoaPods/CocoaPods).

### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "YourPackage",
    dependencies: [
        .Package(url: "https://github.com/vknabel/RxLens.git", majorVersion: 1)
    ]
)
```

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'RxLens', '~> 0.1'
```

## Author

Valentin Knabel, dev@vknabel.com

## License

EasyInject is available under the MIT license. See the LICENSE file for more info.
