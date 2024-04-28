//
//  Home.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI

struct Home: View {

  var body: some View {

    VStack {

      NoteList()
      Spacer()

      HStack {

        Spacer()

      }//:HS

    }//:VS
    .toolbar{
      EditButton()
        .font(.title2)
        .fontWeight(.bold)
        .padding(.trailing,10)
    }
    .frame(maxHeight: .infinity)
    .overlay(
      floatingButton()
        .padding(.bottom,30)
        .padding(.trailing,30)
      ,alignment: .bottomTrailing
    )//:Ov
  }//:bd

}

#Preview{
  Home()
    .modelContainer(for:NoteModel.self)
}
