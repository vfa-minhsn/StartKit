import Testing
@testable import StartKit

@Suite("ExampleViewModel")
struct ExampleViewModelTests {
    @Test @MainActor
    func loadSuccess_setsExampleData() async {
        let expected = ExampleData(id: "id1", content: "content")
        let mock = MockGetExampleDataUseCase(data: expected)
        let sut = ExampleViewModel(getExampleDataUseCase: mock)

        await sut.load(identifier: "id1")

        #expect(sut.exampleData == expected)
        #expect(sut.errorMessage == nil)
        #expect(sut.isLoading == false)
        #expect(mock.receivedIdentifiers == ["id1"])
    }

    @Test @MainActor
    func loadFailure_clearsDataAndSetsMessage() async {
        struct DummyError: Error {}
        let mock = MockGetExampleDataUseCase(error: DummyError())
        let sut = ExampleViewModel(getExampleDataUseCase: mock)

        await sut.load(identifier: "missing")

        #expect(sut.exampleData == nil)
        #expect(sut.errorMessage != nil)
        #expect(sut.isLoading == false)
    }
}
