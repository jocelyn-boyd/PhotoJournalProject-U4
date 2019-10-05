//
//  PhotoPersistence.swift
//  PhotoJournal
//
//  Created by Jocelyn Boyd on 10/4/19.
//  Copyright © 2019 Jocelyn Boyd. All rights reserved.
//

import Foundation

class PhotoPersistenceHelper {
  static let manager = PhotoPersistenceHelper()
  
  func save(newPhoto: PhotoEntry) throws {
    try persistenceHelper.save(newElement: newPhoto)
  }
  
  func getPhotos() throws -> [PhotoEntry] {
    return try persistenceHelper.getObjects()
  }
  
  private let persistenceHelper = PersistenceHelper<PhotoEntry>.init(fileName: "MyPhotos.plist")
  
  private init() {}
}
