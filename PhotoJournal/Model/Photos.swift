//
//  Photos.swift
//  PhotoJournal
//
//  Created by Jocelyn Boyd on 10/4/19.
//  Copyright © 2019 Jocelyn Boyd. All rights reserved.
//

import Foundation

struct PhotoEntry: Codable {
  let photo: Data
  let description: String
  let createdAt: String
}

