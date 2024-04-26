//
//  NoteModel.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/26.
//

import Foundation
import SwiftData

@Model
final class NoteModel {
  var content: String
  var createdAt: Date
  var updatedAt: Date

  init(content: String) {
    self.content = content
    createdAt = Date()
    updatedAt = Date()
  }
}
