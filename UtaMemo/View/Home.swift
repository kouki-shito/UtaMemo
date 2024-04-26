//
//  Home.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI

struct Home: View {

  var body: some View {
    NavigationStack {
      VStack{
//        Rectangle()
//          .frame(width: 100,height: 100)
//          .foregroundColor(.blue)

        Spacer()
        HStack{
          Spacer()
        }//:HStack
      }//:VStack
      .overlay(
        floatingButton()
          .padding(.bottom,30)
          .padding(.trailing,30)
        ,alignment: .bottomTrailing
      )//:Overlay
    }//:NavigationStack
  }//:bodyView

}

#Preview{
  Home()
}
