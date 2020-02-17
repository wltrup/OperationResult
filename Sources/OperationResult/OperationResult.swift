import Foundation

public enum OperationResult<A> {
    
    case success(A)
    case failure([String])
    
    public var value: A? {
        switch self {
        case let .success(a):
            return a
        default:
            return nil
        }
    }
    
    public var failureMessages: [String]? {
        switch self {
        case let .failure(msgs):
            return msgs
        default:
            return nil
        }
    }
    
    public var didSucceed: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    public var didFail: Bool {
        return didSucceed == false
    }
    
}

extension OperationResult: Equatable where A: Equatable {}
extension OperationResult: Hashable where A: Hashable {}

extension OperationResult: Codable where A: Codable {

    enum CodingKeys: CodingKey {
        case success
        case failure
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .success(let value):
            try container.encode(value, forKey: .success)
        case .failure(let value):
            try container.encode(value, forKey: .failure)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let value =  try container.decode(A.self, forKey: .success)
            self = .success(value)
        } catch {
            let value =  try container.decode([String].self, forKey: .failure)
            self = .failure(value)
        }
    }

}
