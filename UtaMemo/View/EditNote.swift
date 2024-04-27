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
  @State private var content : String = ""
  @FocusState var isFocussed : Bool

  var body: some View {
    VStack(spacing:0){
          noteArea
        .ignoresSafeArea()
          .padding(.top,60)
      }//:VStack
            .overlay(
              navigationArea
              ,alignment: .top
            )

  }//:body

}//:View

extension EditNote {

  private var noteArea : some View {

    TextEditor(text: $content)
      .autocorrectionDisabled(true)
      .font(.title)
      .fontWeight(.bold)
      .padding(.horizontal,20)
      .focused($isFocussed)
      .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
      .scrollContentBackground(.hidden)//IOS 16~
      .background(.gray)


  }
  private var navigationArea : some View {
    HStack(alignment:.center){
      Button{

      }label: {
        Image(systemName: "chevron.backward")
        Text("Back")
      }
      Spacer()
      Circle()
        .frame(width: 40,height: 40)
      Circle()
        .frame(width: 40,height: 40)
      Circle()
        .frame(width: 40,height: 40)
    }
    .frame(height: 40)
    .padding(.horizontal)
    .padding(.vertical)
    .background(.white)


  }
}



#Preview {
  EditNote()
}
