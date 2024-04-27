//
//  CodableResponse.swift
//  MoyaCards
//
//  Created by Saw Pyae Yadanar on 26/4/2567 BE.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
  let data: MarvelResults<T>
}

struct MarvelResults<T: Codable>: Codable {
  let results: [T]
}

struct ImgurResponse<T: Codable>: Codable {
  let data: T
}
