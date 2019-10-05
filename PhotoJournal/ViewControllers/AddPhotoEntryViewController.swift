//
//  AddPhotoEntryViewController.swift
//  PhotoJournal
//
//  Created by Jocelyn Boyd on 10/2/19.
//  Copyright © 2019 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AddPhotoEntryViewController: UIViewController {

  var image = UIImage() {
    didSet {
      photoEntryImage.image = image
    }
  }
  
  //MARK: -- Outlets
  @IBOutlet weak var photoEntryImage: UIImageView!
  @IBOutlet weak var journalEntryField: UITextView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

  
  @IBAction func photolibraryButtonPressed(_ sender: UIBarButtonItem) {
    let imagePickerController = UIImagePickerController()
    
    imagePickerController.delegate = self
    imagePickerController.sourceType = .photoLibrary
    present(imagePickerController, animated: true, completion: nil)
  }
  
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    //image
    guard let image = photoEntryImage.image else {return}
    guard let data = image.pngData() else {return}
    
    //createdAT
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = DateFormatter.Style.long
    formatter.timeStyle = .medium
    let timestamp = formatter.string(from: date)
    
    //description
    let description = journalEntryField.text
    
    let newPhotoEntry = PhotoEntry(photo: data, description: description ?? " ", createdAt: timestamp)
    
    //save new entry here with persistence
    do {
      try PhotoPersistenceHelper.manager.save(newPhoto: newPhotoEntry)
      print("Photo Entry successfully saved")
      dismiss(animated: true, completion: nil)
    } catch {
      print(error)
    }
  }
  
  
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  
  
}
//MARK: -- Extentions
extension AddPhotoEntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            //couldn't get image
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
