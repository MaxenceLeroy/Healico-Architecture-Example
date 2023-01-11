struct PostMessageAPI {
  let authorId: String
  let date: Date
  let message: String
  let imageId: String?
}

struct GetMessageAPIBody {
  let items: [GetMessageAPI]
}

struct GetMessageAPI {
  let id: String
  let authorId: String
  let date: Date
  let message: String
  let imageId: String?
}