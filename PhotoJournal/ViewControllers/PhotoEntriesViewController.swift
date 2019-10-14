//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Jocelyn Boyd on 10/2/19.
//  Copyright © 2019 Jocelyn Boyd. All rights reserved.
//

import UIKit

class PhotoEntriesViewController: UIViewController {
  
  //MARK: -- Internal Properties
  private var photos = [PhotoEntry]() {
    didSet {
      photoJournalCollection.reloadData()
    }
  }
  
  //MARK: -- Outlets
  @IBOutlet weak var photoJournalCollection: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photoJournalCollection.dataSource = self
    layout()
  }
  
  //MARK: -- Functions
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    guard let addPhotoVC = storyboard.instantiateViewController(identifier: "PhotoEntryVC") as? AddPhotoEntryViewController else {return}
    addPhotoVC.modalPresentationStyle = .currentContext
    present(addPhotoVC, animated: true, completion: nil)
  }
   
}

//MARK: -- Extentions
extension PhotoEntriesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = photoJournalCollection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
    
    let photo = photos[indexPath.row]
    cell.photoImage.image = UIImage(data: photo.photo)
    cell.entryJournalView.text = photo.description
    cell.createdAtDate.text = photo.createdAt
    
    cell.optionsMenu.tag = indexPath.row
    cell.delegate = self
    return cell
  }
}

extension PhotoEntriesViewController: UICollectionViewDelegateFlowLayout {
  func layout() {
    guard let layout = self.photoJournalCollection.collectionViewLayout as? UICollectionViewFlowLayout else {
             return
         }
    layout.itemSize = CGSize(width: (self.photoJournalCollection.frame.size.width - 20) / 3, height: self.photoJournalCollection.frame.size.height / 4)
         layout.scrollDirection = .horizontal
     }
}

extension PhotoEntriesViewController: PhotoEntryVCDelegate {
  func showActionView(tag: Int) {
    let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an option", preferredStyle: .actionSheet)
    let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
      _ = self.photos[tag]
    }
    optionsMenu.addAction(deleteAction)
  }
}
