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
        List{
          Section{
            NoteList()
          }
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        
        Spacer()
        HStack {
          Spacer()
        }//:HStack
      }//:VStack
      .frame(maxHeight: .infinity)
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
    .modelContainer(for:NoteModel.self)
}
