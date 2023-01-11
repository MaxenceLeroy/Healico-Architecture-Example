class MessageDomainDBConversion {
  // MARK: - Domain to DB
  static func createMessageDB(_ message: Message) -> MessageDB {
    let messageDB = MessageDB()
    messageDB.id = message.id
    messageDB.authorId = message.authorId
    messageDB.date = message.date
    messageDB.message = message.message
    messageDB.imageId = message.imageId
    return userDB
  }
  
  // MARK: - DB to domain
  static func createMessageFromDB(_ messageDB: MessageDB) -> Message {
    Message(
      id: messageDB.id,
      authorId: messageDB.authorId,
      date: messageDB.date,
      message: messageDB.message,
      imageId: messageDB.imageId
    )
  }
}
