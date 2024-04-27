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
          systemName:
            isFocussed == false ? "chevron.backward":"checkmark.circle")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(
            isFocussed == false ? .black : .mint)
      }
      Spacer()
      Circle()
        .frame(width: 40,height: 40)
      Circle()
        .frame(width: 40,height: 40)
      Button{

      }label: {
        Circle()
        //.font(.title3)
          .foregroundColor(.blue)
      }
      .frame(width: 40,height: 40)
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
