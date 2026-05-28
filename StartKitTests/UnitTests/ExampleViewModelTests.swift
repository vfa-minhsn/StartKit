import XCTest
@testable import StartKit

final class ExampleViewModelTests: XCTestCase {
    @MainActor
    func testLoadSuccess_setsExampleData() async {
        let expected = ExampleData(id: "id1", content: "content")
        let mock = MockGetExampleDataUseCase(data: expected)
        let sut = ExampleViewModel(getExampleDataUseCase: mock)

        await sut.load(identifier: "id1")

        XCTAssertEqual(sut.exampleData, expected)
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(mock.receivedIdentifiers, ["id1"])
    }

    @MainActor
    func testLoadFailure_clearsDataAndSetsMessage() async {
        struct DummyError: Error {}
        let mock = MockGetExampleDataUseCase(error: DummyError())
        let sut = ExampleViewModel(getExampleDataUseCase: mock)

        await sut.load(identifier: "missing")

        XCTAssertNil(sut.exampleData)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }
}
