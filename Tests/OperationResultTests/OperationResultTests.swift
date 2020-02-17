import XCTest
@testable import OperationResult

final class OperationResultTests: XCTestCase {

    func test_value_success() {
        let x = 10
        let v = OperationResult<Int>.success(x)
        XCTAssert(v.value == x)
    }

    func test_value_failure() {
        let x = ["Failure Int"]
        let v = OperationResult<Int>.failure(x)
        XCTAssert(v.value == nil)
    }

    func test_failureMessages_success() {
        let x = 10
        let v = OperationResult<Int>.success(x)
        XCTAssert(v.failureMessages == nil)
    }

    func test_failureMessages_failure() {
        let x = ["Failure Int"]
        let v = OperationResult<Int>.failure(x)
        XCTAssert(v.failureMessages == x)
    }

    func test_didSucceed() {
        let x = 10
        let v = OperationResult<Int>.success(x)
        XCTAssert(v.didSucceed)
    }

    func test_didFail() {
        let x = ["Failure Int"]
        let v = OperationResult<Int>.failure(x)
        XCTAssert(v.didFail)
    }

}
