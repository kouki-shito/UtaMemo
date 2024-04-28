//
//  NoteList.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/28.
//

import SwiftUI
import SwiftData

struct NoteList: View {
  @Environment(\.modelContext) private var context
  @Query private var Notes : [NoteModel]

  var body: some View {
      ForEach(Notes){ noteList in
        NavigationLink(value: noteList){
          VStack{
            Text(noteList.createdAt.formatted())
            Text(noteList.title)
            Text(noteList.content)
          }//:VStack
          .navigationDestination(
            for: NoteModel.self) {updateNote in
              EditNote(updateNote: updateNote)
                .toolbar(.hidden)
            }
        }
      }//:ForEach
      .onDelete(perform:deleteNote)
  }//:body

  private func deleteNote(at offsets: IndexSet){
    for offset in offsets {
      let deleteNote = Notes[offset]
      context.delete(deleteNote)
    }
  }

}//:View

#Preview {
  Home()
    .modelContainer(for: NoteModel.self)
}
