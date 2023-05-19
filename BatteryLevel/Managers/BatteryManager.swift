//
//  BatteryManager.swift
//  BatteryLevel
//
//  Created by Lore P on 19/05/2023.
//

import SwiftUI
import WatchConnectivity


class BatteryManager: NSObject, ObservableObject {
  static let shared = BatteryManager()
  
  @Published var iPhoneBatteryLevel: Float = UIDevice.current.batteryLevel
  @Published var iPhoneBatteryState: UIDevice.BatteryState = UIDevice.current.batteryState
  @Published var appleWatchBatteryLevel: Float = 0.0
  
  override init() {
    super.init()
    
    UIDevice.current.isBatteryMonitoringEnabled = true
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(iPhoneBatteryLevelDidChange),
      name: UIDevice.batteryLevelDidChangeNotification,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(iPhoneBatteryStateDidChange),
      name: UIDevice.batteryStateDidChangeNotification,
      object: nil
    )
    
    if WCSession.isSupported() {
      let session = WCSession.default
      session.delegate = self
      session.activate()
    }
  }
  
  @objc private func iPhoneBatteryLevelDidChange(notification: Notification) {
    DispatchQueue.main.async {
      self.iPhoneBatteryLevel = UIDevice.current.batteryLevel
    }
  }
  
  @objc private func iPhoneBatteryStateDidChange(notification: Notification) {
    DispatchQueue.main.async {
      self.iPhoneBatteryState = UIDevice.current.batteryState
    }
  }
}

extension BatteryManager: WCSessionDelegate {
  func sessionDidBecomeInactive(_ session: WCSession) {
    
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    
  }
  
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }
  func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
    if let watchBatteryLevel = applicationContext["watchBatteryLevel"] as? Float {
      DispatchQueue.main.async {
        self.appleWatchBatteryLevel = watchBatteryLevel
      }
    }
  }
}
