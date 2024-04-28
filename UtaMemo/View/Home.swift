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
       NoteList()
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
      .navigationDestination(
        for: NoteModel.self) {updateNote in
          EditNote(updateNote: updateNote)
      }
    }//:NavigationStack
  }//:bodyView

}

#Preview{
  Home()
    .modelContainer(for:NoteModel.self)
}
