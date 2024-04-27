//
//  Marvel.swift
//  MoyaCards
//
//  Created by Saw Pyae Yadanar on 26/4/2567 BE.
//

import Foundation
import Moya

public enum Marvel {
  static private let privateKey = "94dda72c00d021453d6d2787bb7787e9a8edc8e9"
  static private let publicKey = "da3853db0f3ea19777522f3e884dbd7e"

  case comics
}

extension Marvel: TargetType {
  public var baseURL: URL {
    return URL(string: "https://gateway.marvel.com/v1/public")!
  }

  public var path: String {
    switch self {
    case .comics: return "/comics"
    }
  }

  public var method: Moya.Method {
    switch self {
    case .comics: return .get
    }
  }

  public var sampleData: Data {
    return Data()
  }

  public var task: Task {
    let ts = "\(Date().timeIntervalSince1970)"
    let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5

    let authParams = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash]
    debugPrint("\n")
    debugPrint("ts \(ts)")
    debugPrint("hash \(hash)")
    switch self {
    case .comics:
      return .requestParameters(parameters: ["format": "comic",
                                             "formatType": "comic",
                                             "orderBy": "-onsaleDate",
                                             "dateDescriptor": "lastWeek",
                                             "limit": 50] + authParams,
                                encoding: URLEncoding.default)
    }
  }

  public var headers: [String: String]? {
    return ["Content-Type": "application/json"]
  }

  public var validationType: ValidationType {
    return .successCodes
  }
}
