# OperationResult
![](https://img.shields.io/badge/platforms-iOS%2010%20%7C%20tvOS%2010%20%7C%20watchOS%204%20%7C%20macOS%2010.14-red)
[![Xcode](https://img.shields.io/badge/Xcode-11-blueviolet.svg)](https://developer.apple.com/xcode)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/wltrup/OperationResult)
![GitHub](https://img.shields.io/github/license/wltrup/OperationResult/LICENSE)

## What

**OperationResult** is a Swift Package Manager package for iOS/tvOS (10.0 and above), watchOS (4.0 and above), and macOS (10.14 and above), under Swift 5.0 and above,  defining an enumeration similar to `Result` but with `Array<String>` in place of an error type:
```swift
public enum OperationResult<A> {
    
    case success(A)
    case failure([String])
    
    public var value: A?
    public var failureMessages: [String]?
    
    public var didSucceed: Bool
    public var didFail: Bool

    public func map<B> (_ transform: (A) -> B) -> OperationResult<B>

}

extension OperationResult: Equatable where A: Equatable {}
extension OperationResult: Hashable where A: Hashable {}

extension OperationResult: Codable where A: Codable {

    enum CodingKeys: CodingKey {
        case success
        case failure
    }

    public func encode(to encoder: Encoder) throws
    public init(from decoder: Decoder) throws

}
```

One neat use for this type is when considering a long sequence of numerical operations, some of which may fail. For example, division by zero, logarithm of a non-positive number, arc-sine or arc-cosine of a number with a magnitude larger than 1, and so on. Rather than stop the execution with throw-catches or risk runtime errors, the `OperationResult<A>` type allows a clean progression to the end, accumulating error messages along the way.  Here's a representative implementation, using division as an example:
```swift
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
```

## Installation

**OperationResult** is provided only as a Swift Package Manager package, because I'm moving away from CocoaPods and Carthage, and can be easily installed directly from Xcode.

## Author

Wagner Truppel, trupwl@gmail.com

## License

**OperationResult** is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
