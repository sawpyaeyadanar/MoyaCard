//
//  UploadResult.swift
//  MoyaCards
//
//  Created by Saw Pyae Yadanar on 26/4/2567 BE.
//

import Foundation
struct UploadResult: Codable, CustomDebugStringConvertible {
  let deletehash: String
  let link: URL

  var debugDescription: String {
    return "<UploadResult:\(deletehash)> \(link)"
  }
}
