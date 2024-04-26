//
//  EditNote.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI
import SwiftData
struct EditNote: View {
  @Environment(\.modelContext) var context
  @State private var content : String = ""
  var body: some View {
    VStack{
      Form{
        TextField(
          "Enter Here",
          text: $content,
          axis: .vertical
        )
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
      }//:Form
    }//:VStack
  }//:body
}//:View

#Preview {
  EditNote()
}
