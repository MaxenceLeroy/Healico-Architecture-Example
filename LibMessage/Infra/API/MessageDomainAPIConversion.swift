class MessageDomainAPIConversion {
  // MARK: - Domain to API
  static func createMessageAPI(_ message: Message) -> PostMessageAPI {
    PostMessageAPI(
      authorId: message.authorId,
      date: message.date,
      message: message.message,
      imageId: message.imageId
    )
  }
  
  // MARK: - DB to domain
  static func createMessageFromAPI(_ messageAPI: GetMessageAPI) -> Message {
    Message(
      id: messageAPI.id,
      authorId: messageAPI.authorId,
      date: messageAPI.date,
      message: messageAPI.message,
      imageId: messageAPI.imageId
    )
  }
}
