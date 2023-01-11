import LibUser
import Resolver
import RxSwift
import UIKit

class LibMessageModule {
  @Injected var userModule: LibUserModule

  @Injected var fetchMessagesCommand: FetchMessagesCommand
  @Injected var postmessageCommand: PostMessageCommand
  @Injected var getMessagesQuery: GetMessagesQuery

  public func fetchMessages() -> Single<Void> {
    userModule
      .getCurrentUserId()
      .flatMap { userId ->
        self.fetchMessagesCommand.execute(userId: userId)
      }
  }

  public func postMessage(messageText: String, messageImage: UIImage?) -> Single<Void> {
    userModule
      .getCurrentUserId()
      .flatMap { userId ->
        self.postmessageCommand.execute(userId: userId, messageText: messageText, messageImage: messageImage)
      }
  }

  public func getMessages() -> Observable<[Message]> {
    getMessagesQuery.execute()
  }
}