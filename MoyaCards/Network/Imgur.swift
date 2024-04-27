//
//  Imgur.swift
//  MoyaCards
//
//  Created by Saw Pyae Yadanar on 26/4/2567 BE.
//

import Foundation
import UIKit
import Moya

public enum Imgur {
  static private let clientId = "f1295dccb1c586e"

  case upload(UIImage)
  case delete(String)
}

extension Imgur: TargetType {
  public var baseURL: URL {
    return URL(string: "https://api.imgur.com/3")!
  }

  public var path: String {
    switch self {
    case .upload: return "/image"
    case .delete(let deletehash): return "/image/\(deletehash)"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .upload: return .post
    case .delete: return .delete
    }
  }

  public var sampleData: Data {
    return Data()
  }

  public var task: Task {
    switch self {
    case .upload(let image):
      let imageData = image.jpegData(compressionQuality: 1.0)!

      return .uploadMultipart([MultipartFormData(provider: .data(imageData),
                                                 name: "image",
                                                 fileName: "card.jpg",
                                                 mimeType: "image/jpg")])
    case .delete:
      return .requestPlain
    }
  }

  public var headers: [String: String]? {
    return [
      "Authorization": "Client-ID \(Imgur.clientId)",
      "Content-Type": "application/json"
    ]
  }

  public var validationType: ValidationType {
    return .successCodes
  }
}
