//
//  EditNote.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI
import UIKit
import SwiftData

struct NewNote: View {

  @Environment(\.modelContext) var context
  @Environment(\.dismiss) private var dismiss
  @State private var noteContent : String = ""
  @State private var noteTitle : String = ""
  @State private var CanUndo : Bool = false
  @State private var CanRedo : Bool = false
  @FocusState var isFocussed : Bool

  var body: some View {
    VStack(spacing:0){
      titleArea
      noteArea
    }//:VStack
    .padding(.top,70)
    .overlay(
      navigationArea
      ,alignment: .top
    )

  }//:body

}//:View

extension NewNote {

  private func addNote(){
    let newNote = NoteModel(content: noteContent,title: noteTitle)
    context.insert(newNote)
  }
  private func saveNote(){
    try? context.save()
  }
//  private func deleteNote(at offsets: IndexSet){
//    for offset in offsets {
//      let deleteNote = Notes[offset]
//      context.delete(deleteNote)
//    }
//  }

  private var navigationArea : some View {
    HStack(alignment:.center){
      //MARK: -BACKANDFOCUS
      HStack{
        Button{
          if isFocussed == false{
            //Back Home
            if noteContent == "" && noteTitle == ""{

            }else{
              addNote()
            }

            dismiss()
          }else{
            //disable Note Focus
            isFocussed = false
          }
        }label: {
          Image(
            systemName:isFocussed == false ? "chevron.backward":"checkmark.circle")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(
            isFocussed == false ? .black : .green)
        }
        .animation(.linear(duration: 0.1),
                   value: isFocussed)
        Spacer(minLength: 0)
      }

      //MARK: -UNDOREDO
      Button {
        //Undo
      }label: {
        Image(systemName: "arrow.backward")
          .font(.title2)
          .opacity(isFocussed == true ? 1 : 0)

      }
      .padding(.leading)
      .frame(width: 40,height: 40)
      .disabled(!isFocussed || !CanUndo)
      .animation(
        .linear(duration: 0.1),
        value:isFocussed)

      Button{
        //Redo
      }label: {
        Image(systemName: "arrow.forward")
          .font(.title2)
          .opacity(
            isFocussed == true ? 1 : 0)
      }
      .frame(width: 40,height: 40,alignment: .center)
      .disabled(!isFocussed || !CanRedo)
      .animation(.linear(duration: 0.1), value:isFocussed)

      //MARK: -MENUBUTTON
      HStack{
        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        Button{
          //menuButton
        }label: {
          Image(systemName: "line.horizontal.3.circle")
            .font(.title)
        }
        .frame(width: 40,height: 40)

      }
    }
    .frame(height: 30)
    .padding(.horizontal)
    .padding(.vertical)
    .background(.white)
  }

  private var titleArea : some View {
    TextField("題名", text: $noteTitle)
      .font(.title)
      .fontWeight(.heavy)
      .padding()
      .focused($isFocussed)
      .onChange(of: isFocussed){
        saveNote()
      }
  }

  private var noteArea : some View {

    TextEditor(text: $noteContent)
      .autocorrectionDisabled(true)
      .font(.title2)
      .fontWeight(.bold)
      .padding(.horizontal,20)
      .focused($isFocussed)
      .scrollContentBackground(.hidden)
      .toolbar{
        ToolbarItemGroup(placement:.keyboard){
          //KeyBoardToolBar
          Button{

          }label: {
            Image(systemName: "rectangle.inset.fill")
              .foregroundColor(.yellow)
              .font(.title2)
            //.frame(width: 30,height: 30)
          }
          Spacer()
          Button{

          }label: {
            Image(systemName: "pencil.circle")
              .foregroundColor(.blue)
              .font(.title2)
            //.frame(width: 30,height: 30)
          }
        }
      }
      .onChange(of: isFocussed){
        saveNote()
      }
  }


}//:Extension



#Preview {
  NewNote()
    .modelContainer(for:NoteModel.self)
}

