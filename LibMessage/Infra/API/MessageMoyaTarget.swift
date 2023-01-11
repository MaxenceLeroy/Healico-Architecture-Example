import CoreAPI
import Moya

enum MessageMoyaTarget {
  case getMessages(userId: String)
  case postMessage(userId: String, messageId: String, messageBody: PostMessageAPI)
}

extension MoyaPatientAPITarget: TargetType {
  var baseURL: URL {
    // Value stored in CoreAPI
    ServerConfiguration.address
  }

  var path: String {
    switch self {
    case let .getMessages(userId):
      return "/v1/users/\(userId)/messages"

    case let .postMessage(userId, messageId, _):
      return "/v1/users/\(userId)/messages/\(messageId)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getMessages:
      return .get
    case .postMessage:
      return .post
    }
  }

  var sampleData: Data {
    Data()
  }

  var task: Task {
    switch self {
    case .getMessages:
      return .requestPlain

    case let .postMessage(_, _, messageBody):
      return .requestJSONEncodable(messageBody)
    }
  }

  var headers: [String: String]? {
      // POST headers (content-type and content-length) are handled by Moya
      ["Accept": "application/json"]
  }
}
