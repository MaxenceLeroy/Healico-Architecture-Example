import Foundation
import UIKit

public struct Message: Equatable {
  public let id: String
  public let authorId: String
  public let date: Date
  public let message: String
  public let imageId: String?
}