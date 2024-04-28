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

      List(){
        Section{
          ForEach(Notes){ noteList in
            NavigationLink(value: noteList){
              VStack{
                Text(noteList.title)
                  .font(.title2)
                  .fontWeight(.bold)
                  .multilineTextAlignment(.leading)
                Text(noteList.content)
                  .multilineTextAlignment(.leading)
              }//:VStack
            }//:NAVI
          }//:ForEach
          .onDelete(perform:deleteNote)
        }//:Sec
      }//:List
      .listStyle(.grouped)
      .scrollContentBackground(.hidden)


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
