import Resolver
import RxSwift

class GetMessagesQuery {
  @Injected var storage: MessageStorage

  func execute() -> Observable<[Message]> {
    storage.getMessages()
  }
}
