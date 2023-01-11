@objcMembers
class MessageDB: Object {
  dynamic var id: String!
  dynamic var authorId: String!
  dynamic var date: Date!
  dynamic var message: String!
  dynamic var imageId: String?

  override static func primaryKey() -> String? {
    "id"
  }
}