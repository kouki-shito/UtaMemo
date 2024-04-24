//
//  CustomTab.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI

enum Tab:String,CaseIterable {
  case folder = "folder"
  case home = "home"
  case settings = "settings"

  var systemImage:String {
    switch self {
    case .folder:
      return "folder"
    case .home:
      return "house"
    case .settings:
      return "gearshape"
    }
  }

  var index: Int {
    return Tab.allCases.firstIndex(of: self) ?? 0
  }


}
