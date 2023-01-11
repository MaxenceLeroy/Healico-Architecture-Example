import Resolver

// Extension for dependecy injection: here we register all the classes
extension Resolver {
  public static func registerLibMessage() {
    registerModule()
    registerInfra()
    registerBusiness()
  }

  private static func registerModule() {
    register { LibMessageModule() }
  }

  private static func registerInfra() {
    register { RealmMessageStorage() as MessageStorage }.scope(.application)
    register { MessageMoyaAPIService as MessageAPIService }
  }

  private static func registerBusiness() {
    register { FetchMessagesCommand() }
    register { PostMessageCommand() }
    register { GetMessagesQuery() }
  }
}