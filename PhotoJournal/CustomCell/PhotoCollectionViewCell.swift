//
//  PhotoCollectionViewCell.swift
//  PhotoJournal
//
//  Created by Jocelyn Boyd on 10/2/19.
//  Copyright © 2019 Jocelyn Boyd. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
  weak var delegate: PhotoEntryVCDelegate?
  
  @IBOutlet weak var photoImage: UIImageView!
  @IBOutlet weak var createdAtDate: UILabel!
  @IBOutlet weak var entryJournalView: UITextView!
  @IBOutlet weak var optionsMenu: UIButton!
  
  
  @IBAction func optionsButtonPressed(_ sender: UIButton) {
  delegate?.showActionView(tag: sender.tag)
  }
  
  
}
