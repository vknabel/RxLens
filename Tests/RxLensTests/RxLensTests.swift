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
            it("may have a child") {
                let nameCharacters = Person.nameLens.child(with: Lens<String, String.CharacterView>(
                    from: { (string: String) in string.characters },
                    to: { (characterView: String.CharacterView, string: String) -> String in
                        String(characterView)
                    }
                ))
                expect(String(nameCharacters.from(Person(name: "Valentin Knabel")))) == "Valentin Knabel"
                expect(nameCharacters.to("New name".characters, Person(name: "Valentin Knabel"))) == Person(name: "New name")
            }
            it("may have an inline child") {
                let nameCharacters = Person.nameLens.child(
                    from: { (string: String) in string.characters },
                    to: { (characterView: String.CharacterView, string: String) -> String in
                        String(characterView)
                    }
                )
                expect(String(nameCharacters.from(Person(name: "Valentin Knabel")))) == "Valentin Knabel"
                expect(nameCharacters.to("New name".characters, Person(name: "Valentin Knabel"))) == Person(name: "New name")
            }
            it("may be used as child") {
                let nameCharacters = Lens<String, String.CharacterView>(
                    from: { (string: String) in string.characters },
                    to: { (characterView: String.CharacterView, string: String) -> String in
                        String(characterView)
                    }
                ).asChild(of: Person.nameLens)
                expect(String(nameCharacters.from(Person(name: "Valentin Knabel")))) == "Valentin Knabel"
                expect(nameCharacters.to("New name".characters, Person(name: "Valentin Knabel"))) == Person(name: "New name")
            }
            it("may be used as inline child") {
                let nameCharacters = Lens<String, String.CharacterView>(
                    from: { (string: String) in string.characters },
                    to: { (characterView: String.CharacterView, string: String) -> String in
                        String(characterView)
                    }
                    ).asChild(from: Person.nameLens.from, to: Person.nameLens.to)
                expect(String(nameCharacters.from(Person(name: "Valentin Knabel")))) == "Valentin Knabel"
                expect(nameCharacters.to("New name".characters, Person(name: "Valentin Knabel"))) == Person(name: "New name")
            }
        }
    }

    static var allSpecs : [(String, (RxLensTests) -> () throws -> Void)] {
        return [
            ("spec", spec),
        ]
    }
}
