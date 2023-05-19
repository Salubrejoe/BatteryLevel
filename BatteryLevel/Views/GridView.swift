//
//  GridView.swift
//  BatteryLevel
//
//  Created by Lore P on 19/05/2023.
//

import SwiftUI

struct GridView: View {
  
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 10) {
        GridItemView()
        GridItemView()
        GridItemView()
        GridItemView()
        GridItemView()
      }
    }//: ScrollView
    .navigationTitle("Battery")
  }
}

struct GridView_Previews: PreviewProvider {
  static var previews: some View {
    GridView()
  }
}
