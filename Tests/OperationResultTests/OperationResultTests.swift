import XCTest
@testable import OperationResult

typealias NumericalResult = OperationResult<Double>

extension NumericalResult {
    static func / (lhs: NumericalResult, rhs: NumericalResult) -> NumericalResult {
        switch (lhs, rhs) {

        case let (.success(a), .success(b)):
            guard b != 0 else { return .failure(["Division of \(a) by zero"]) }
            return .success(a/b)

        case let (.failure(a), .success(_)):
            return .failure(a)

        case let (.success(_), .failure(b)):
            return .failure(b)

        case let (.failure(a), .failure(b)):
            return .failure(a + b)

        }
    }
}

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

    func test_map_success() {
        let x = OperationResult<Int>.success(5)
        let v = x.map { a in a * a }
        XCTAssert(v == .success(25))
    }

    func test_map_failure() {
        let x = OperationResult<Int>.failure(["Invalid operation"])
        let v = x.map { a in a * a }
        XCTAssert(v == .failure(["Invalid operation"]))
    }

    func test_division_success_success() {
        let x = OperationResult<Double>.success(5)
        let y = OperationResult<Double>.success(2)
        let v = x / y
        XCTAssert(v == .success(2.5))
    }

    func test_division_success_failure() {
        let x = OperationResult<Double>.success(5)
        let y = OperationResult<Double>.failure(["Some failure message"])
        let v = x / y
        XCTAssert(v == .failure(["Some failure message"]))
    }

    func test_division_failure_success() {
        let x = OperationResult<Double>.failure(["Some failure message"])
        let y = OperationResult<Double>.success(2)
        let v = x / y
        XCTAssert(v == .failure(["Some failure message"]))
    }

    func test_division_failure_failure() {
        let x = OperationResult<Double>.failure(["Failure 1"])
        let y = OperationResult<Double>.failure(["Failure 2"])
        let v = x / y
        XCTAssert(v == .failure(["Failure 1", "Failure 2"]))
    }

    func test_division_by_zero() {
        let x = OperationResult<Double>.success(5)
        let y = OperationResult<Double>.success(0)
        let v = x / y
        XCTAssert(v == .failure(["Division of 5.0 by zero"]))
    }

}
