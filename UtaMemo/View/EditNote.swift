//
//  EditNote.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI
import UIKit
import SwiftData

struct EditNote: View {

  @Environment(\.modelContext) var context
  @Environment(\.dismiss) private var dismiss
  @State private var content : String = ""
  @State private var contentTitle : String = ""
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

extension EditNote {

  private var navigationArea : some View {
    HStack(alignment:.center){
      //MARK: -BACKANDFOCUS
      HStack{
        Button{
          if isFocussed == false{
            //Back Home
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
    TextField("題名", text: $contentTitle)
      .font(.title)
      .fontWeight(.heavy)
      .padding()
      .focused($isFocussed)
  }

  private var noteArea : some View {

    TextEditor(text: $content)
      .autocorrectionDisabled(true)
      .font(.title)
      .fontWeight(.bold)
      .padding(.horizontal,20)
      .focused($isFocussed)
    //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
      .scrollContentBackground(.hidden)//IOS 16~
    //.background(.gray)
  }

}



#Preview {
  EditNote()
}
