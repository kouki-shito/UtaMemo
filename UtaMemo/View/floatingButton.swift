//
//  floatingButton.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/25.
//

import SwiftUI

struct floatingButton: View {
  @State private var AnimatedButton : Bool = false
  @State private var isButtonActive : Bool = false
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()

        HStack{
          Spacer()
        }
        .foregroundColor(Color("BaseColor"))

      }
      .overlay(
        ZStack {
          Group{
            Circle()
              .fill(Color.blue)
              .opacity(self.AnimatedButton ? 0.15 : 0)
              .scaleEffect(self.AnimatedButton ? 1 : 0)
              .frame(width: 68,height: 68,alignment: .center)
          }

          Button(){
            isButtonActive.toggle()
            print(isButtonActive)
          }label: {
            Image(systemName: "plus.circle.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 48,height: 48,alignment: .center)
              .background(Circle().fill(.white))
          }//:label
          .onAppear(perform: {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)){
              self.AnimatedButton.toggle()
            }
          })
        }//:ZTACKS
          .padding(.bottom,30)
          .padding(.trailing,30)
        ,alignment: .bottomTrailing
      )//:Overlay
      .navigationDestination(isPresented: $isButtonActive) {
        EditNote()
      }
    }//:Navigation

  }
}

#Preview {
    floatingButton()
}
