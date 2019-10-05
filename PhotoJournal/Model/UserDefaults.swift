//
//  UserDefaults.swift
//  PhotoJournal
//
//  Created by Jocelyn Boyd on 10/2/19.
//  Copyright © 2019 Jocelyn Boyd. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
  
  private init() {}
  
  static let userSettings = UserDefaultsWrapper()
  
  //option for setting the background color
  private let darkModeKey = "darkMode"
  
  //option for setting the scroll direction of the Collection View
  private let scrollDirectionKey = "scrollDirection"
  
  
  func store(darkMode: Bool) {
    UserDefaults.standard.set(darkMode, forKey: darkModeKey)
  }
  
  func switchToDarkMode() -> Bool? {
    return UserDefaults.standard.value(forKey: darkModeKey) as? Bool
  }
  
  func store(scrollDirection: Bool) {
    UserDefaults.standard.set(scrollDirection, forKey: scrollDirectionKey)
  }
  
  func switchScrollDirection() -> Bool? {
    return UserDefaults.standard.value(forKey: scrollDirectionKey) as? Bool
  }
  
}


