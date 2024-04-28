//
//  UtaMemoApp.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI
import SwiftData

@main
struct UtaMemoApp: App {

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for:NoteModel.self)
  }
}
