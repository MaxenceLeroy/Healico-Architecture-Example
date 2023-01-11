import CoreAPI
import Moya
import RxMoya

protocol MessageAPIService {
  func getMessages(userId: String) -> Single<[Message]>
  func postMessage(userId: String, message: Message) -> Single<Void>
}

class MessageMoyaAPIService: MessageAPIService {
  // MyProvider is based on Moya provider with a few extra
  let provider = MyProvider<MessageMoyaTarget>()

  func getMessages(userId: String) -> Single<[Message]> {
    provider
      .request(.getMessages(userId: userId))
      .map(GetMessageAPIBody.self)
      .map { messageBody in
        messageBody.items.map(MessageDomainAPIConversion.createMessageFromAPI)
      }
  }

  func postMessage(userId: String, message: Message) -> Single<Void> {
    provider
      .request(.postMessage(
        userId: userId, 
        messageId: message.id, 
        messageBody: MessageDomainAPIConversion.createMessageAPI(message)))
      .map { _ in ()}
  }
}