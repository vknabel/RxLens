import XCTest
import Quick
import Nimble
@testable import RxLens

fileprivate struct Person: Equatable {
    let name: String

    static var nameLens: Lens<Person, String> {
        return Lens(
            from: { $0.name },
            to: { name, _ in Person(name: name) }
        )
    }

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}

class RxLensTests: QuickSpec {
    override func spec() {
        describe("lens") {
            it("returns property") {
                let person = Person(name: "Valentin Knabel")
                expect(Person.nameLens.from(person)) == "Valentin Knabel"
            }
            it("changes property") {
                let person = Person(name: "Valentin Knabel")
                expect(Person.nameLens.to("New Name", person)) == Person(name: "New Name")
            }
        }
    }

    static var allSpecs : [(String, (RxLensTests) -> () throws -> Void)] {
        return [
            ("spec", spec),
        ]
    }
}
