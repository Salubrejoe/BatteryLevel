//
//  ContentView.swift
//  BatteryLevel
//
//  Created by Lore P on 19/05/2023.
//

import SwiftUI

struct ContentView: View {
//  @ObservedObject var manager = BatteryManager.shared
  
  var body: some View {
    NavigationStack {
      ZStack {
        LinearGradient(gradient: Gradient(stops: [
          Gradient.Stop(color: Color.red, location: 0),
          Gradient.Stop(color: Color.orange, location: 0.5),
          Gradient.Stop(color: Color.yellow, location: 1)
        ]), startPoint: .bottomLeading, endPoint: .topTrailing)
        .ignoresSafeArea()
        
        GridView()
          .padding(.all, 40)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
