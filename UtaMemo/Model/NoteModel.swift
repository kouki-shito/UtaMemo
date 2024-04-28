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
  var id : String = UUID().uuidString
  var content: String = ""
  var title : String = ""
  var createdAt: Date
  var updatedAt: Date

  init(content: String,title:String) {
    self.content = content
    self.title = title
    createdAt = Date()
    updatedAt = Date()
  }
}
