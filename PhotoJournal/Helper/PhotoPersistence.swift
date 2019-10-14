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
  
  func fetchPhotos() throws -> [PhotoEntry] {
    return try persistenceHelper.getObjects()
  }
  
  func delete(tag: Int) throws {
    var photos = try fetchPhotos()
    _ = photos.remove(at: tag)
    try persistenceHelper.replace(elements: photos)
    print("Photo successfully deleted")
  }
  
  func saveEdits(to edittedPhoto: PhotoEntry, tag: Int) throws {
    var photos = try fetchPhotos()
    photos[tag] = edittedPhoto
    try persistenceHelper.replace(elements: photos)
  }
  
  private let persistenceHelper = PersistenceHelper<PhotoEntry>.init(fileName: "MyPhotos.plist")
  
  private init() {}
}

