import CoreFileUpload
import CorePicture
import Resolver
import RxSwift
import UIKit

class PostMessageCommand {
  @Injected var fileModule: CoreFileUploadModule
  @Injected var pictureModule: CorePictureModule

  @Injected var apiService: MessageAPIService
  @Injected var storage: MessageStorage

  func execute(userId: String, messageText: String, messageImage: UIImage?) -> Single<Void> {
    let imageId: String?
    let sendImageSingle: Single<Void>

    // Specific code if an image is attached to the message
    if let image = messageImage {
      // We attribute it an id
      imageId = UUID().uuidString.lowercased()

      pictureModule.addImageToCache(image: image, imageId: imageId)

      sendImageSingle = fileModule.uploadFile(file: image.jpegData(compressionQuality: 1.0), fileId: imageId)
    } else {
      imageId = nil
      sendImageSingle = Single.just(())
    }

    let messageId = UUID().uuidString.lowercased()
    let message = Message(
      id: messageId,
      authorId: userId,
      date: Date(),
      message: messageText,
      imageId: imageId
    )

    return sendImageSingle
      .flatMap { _ in self.apiService.postMessage(userId: userId, message: message)}
      .flatMap { _ in self.storage.addMessage(message)}
  }
}