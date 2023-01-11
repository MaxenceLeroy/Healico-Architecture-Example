import Realm
import RxRealm
import RxSwift

protocol MessageStorage {
  func getMessages() -> Observable<[Message]>
  func setMessages(_ messages: [Message]) -> Single<Void>
  func addMessage(_ message: Message) -> Single<Void>
}

class RealmMessageStorage: MessageStorage {
  let realm: Realm = {
    var config = Realm.Configuration()
    // Use the default directory, but replace the filename with the lib name
    let path = config.fileURL!.deletingLastPathComponent().appendingPathComponent("message.realm")
    config.fileURL = path
    config.deleteRealmIfMigrationNeeded = true
    onfig.objectTypes = [MessageDB.self]
    return Realm(configuration: config)
  }()

  func getMessages() -> Observable<[Message]> {
    Observable.array(from: realm.objects(MessageDB.self))
      .map { messageListDB in
        messageListDB.map(MessageDomainDBConversion.createMessageFromDB)
      }
  }

  func setMessages(_ messages: [Message]) -> Single<Void> {
    do {
        try realm.write {
            realm.add(messages, update: .modified)
        }
        return Single.just(())
    } catch {
        return Single.error(MessageError.realmError)
    }
  }

  func addMessage(_ message: Message) -> Single<Void> {
    do {
        try realm.write {
            realm.add(message, update: .modified)
        }
        return Single.just(())
    } catch {
        return Single.error(MessageError.realmError)
    }
  }
}