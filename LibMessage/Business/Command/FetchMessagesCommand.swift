import Resolver
import RxSwift

class FetchMessagesCommand {
  @Injected var apiService: MessageAPIService
  @Injected var storage: MessageStorage

  func execute(userId: String) -> Single<Void> {
    apiService
      .getMessages(userId: userId)
      .flatMap(storage.setMessages)
  }
}