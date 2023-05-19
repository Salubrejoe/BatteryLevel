//
//  GridItem.swift
//  BatteryLevel
//
//  Created by Lore P on 19/05/2023.
//

import DeviceKit
import SwiftUI
import MarqueeText

struct GridItemView: View {
  var device = Device.current
  @State private var isAnimating = false
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20)
        .fill(.ultraThinMaterial)
      
      VStack {
        HStack {
          Image(systemName: getImage())
            .resizable()
            .scaledToFit()
            .frame(height: 15)
            .padding(.leading, 15)
          MarqueeText(text: device.name ?? "UNNOWN DEVICE",
                      font: UIFont.preferredFont(forTextStyle: .caption1),
                      leftFade: 10,
                      rightFade: 20,
                      startDelay: 3)
            .padding(.trailing, 15)
        }
        .offset(y: -8)
        
        Gauge(value: isAnimating ?  percentage() : 0) {
          Text("\(device.batteryLevel ?? 0)%")
            .font(.system(size: 30))
        }
        .gaugeStyle(CustomGaugeStyle(size: 90))
        .offset(y: -10)
        .animation(.spring().delay(0.6), value: isAnimating)
        .padding(.top, 3)
        .onAppear { isAnimating.toggle() }
      }
    }
    .frame(width: 150, height: 150)
  }
  
  func getImage() -> String {
    if device.isPad { return "ipad"}
    else if device.isPhone { return "iphone"}
    else if !device.hasCamera { return "applewatch"}
    else { return "xmark"}
  }
  
  func percentage() -> Double {
    guard let percentage = device.batteryLevel else { return -1}
    
    return Double(percentage) / 100
  }
  
  struct CustomGaugeStyle: GaugeStyle {
    var size: CGFloat
    func makeBody(configuration: GaugeStyleConfiguration) -> some View {
      ZStack {
        let green = Color(uiColor: .systemGreen)
        Circle()
          .stroke(.ultraThinMaterial, lineWidth: 6)
          .frame(width: size, height: size)
        
        Circle()
          .trim(from: 0, to: CGFloat(configuration.value))
          .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
          .frame(width: size, height: size)
          .foregroundColor(green)
          .shadow(color: .green.opacity(0.2), radius: 5, y: 5)
          .rotationEffect(Angle(degrees: -90))
          
        Text("\(Int(configuration.value * 100))")
          .font(.largeTitle)
      }
    }
  }
}

struct GridItemView_Previews: PreviewProvider {
  static var previews: some View {
    GridItemView()
  }
}
