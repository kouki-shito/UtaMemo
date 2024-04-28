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
    NavigationStack{
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
        }label: {
          Image(systemName: "plus.circle.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.blue)
            .frame(width: 48,height: 48,alignment: .center)
            .shadow(radius: 1,x: 0,y: 2)
            .background(Circle().fill(.white))

        }//:label
        .onAppear(perform: {
          withAnimation(
            .easeInOut(duration: 1.5)
            .repeatForever(autoreverses: true)){
              self.AnimatedButton.toggle()
            }
        })
      }//:ZTACKS
      .navigationDestination(isPresented: $isButtonActive) {
        NewNote()
          .toolbar(.hidden)

      }
    }
  }
}

#Preview {
    floatingButton()
}
