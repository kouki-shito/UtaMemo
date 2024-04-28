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
  @State private var selectionValue: Int? = nil
  @Query private var Notes : [NoteModel]

  var body: some View {

      List(selection:$selectionValue){
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
              .navigationDestination(
                for: NoteModel.self) {updateNote in
                  EditNote(updateNote: updateNote)
                    .toolbar(.hidden)
                }
            }//:NAVI
          }//:ForEach
          .onDelete(perform:deleteNote)
        }//:Sec
      }//:List
      .toolbar{
        EditButton()
//        Button(){
//
//        }label: {
//          Image(systemName: "trash")
//            .font(.title3)
//            .padding(.bottom)
//
//
//        }
      }
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
