//
//  ContentView.swift
//  UtaMemo
//
//  Created by 市東 on 2024/04/24.
//

import SwiftUI

struct ContentView: View {
  @State private var activeTab :Tab = .home
  var body: some View {
    NavigationStack{
      VStack(spacing:0){

        TabView(selection:$activeTab) {
          FolderPage()
            .tag(Tab.folder)
          Home()
            .tag(Tab.home)
          SettingsPage()
            .tag(Tab.settings)
        }//:TabView
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.default,value: activeTab)

        CustomTabBar()

      }//:VStack
    }
  }//:BODY

  //EASY Custom Tab View
  @ViewBuilder
  func CustomTabBar(_ tint: Color = Color(.blue), _ inactiveTint:Color = .blue) -> some View{

    HStack(spacing:0) {
      ForEach(Tab.allCases,id: \.rawValue){
        TabItem(
          tint: tint,
          inactiveTint:inactiveTint,
          tab: $0,
          activeTab:$activeTab)
      }
    }//:HStack

    .padding(.horizontal,15)
    .padding(.vertical,10)
  }
}

//Tab Items
struct TabItem :View {
  var tint : Color
  var inactiveTint : Color
  var tab : Tab

  @Binding var activeTab : Tab

  var body: some View {
    VStack{
      Image(systemName: tab.systemImage)
        .font(.title2)
        .foregroundColor(activeTab == tab ? tint : .primary)//DarkMode Ok
        .frame(width: 35,height: 35)
      
    }
    .frame(maxWidth:.infinity)
    .contentShape(Rectangle())
    .onTapGesture {
      activeTab = tab
    }
  }
}


#Preview {
  ContentView()
}
