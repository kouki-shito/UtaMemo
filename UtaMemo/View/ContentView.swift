//
//  ContentView.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    
    NavigationStack {
      VStack(spacing:0){

          Home()

      }
      .navigationDestination(
        for: NoteModel.self) {updateNote in
          EditNote(updateNote: updateNote)
            .toolbar(.hidden)

        }
    }//:V
  }//:Body

}


#Preview {
  ContentView()
    .modelContainer(for:NoteModel.self)
}
