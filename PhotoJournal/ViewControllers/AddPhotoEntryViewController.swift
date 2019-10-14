//
//  AddPhotoEntryViewController.swift
//  PhotoJournal
//
//  Created by Jocelyn Boyd on 10/2/19.
//  Copyright © 2019 Jocelyn Boyd. All rights reserved.
//

import UIKit

class AddPhotoEntryViewController: UIViewController {

  //MARK: -- Internal Properties
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
     setTextViewBorder()
  }

  //MARK: -- Functions
  private func setTextViewBorder() {
    self.journalEntryField.layer.borderWidth = 0.5
    self.journalEntryField.layer.borderColor = UIColor.black.cgColor
    self.journalEntryField.text = "Placeholder"
    self.journalEntryField.textColor = UIColor.lightGray
  }
  
  //MARK: -- Toolbar Functions
  @IBAction func photolibraryButtonPressed(_ sender: UIBarButtonItem) {
    let imagePickerController = UIImagePickerController()
    
    imagePickerController.delegate = self
    imagePickerController.sourceType = .photoLibrary
    present(imagePickerController, animated: true, completion: nil)
  }
  
  // -- feature doesn't work in simulator, will break program
  // -- run it on iPhone to test
  @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
    let imagePickerController = UIImagePickerController()
    
    imagePickerController.delegate = self
    imagePickerController.sourceType = .camera
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
  
  //TODO: -- TextView Stuff
  func textViewDidBeginEditing(_ textView: UITextView) {
  if textView.textColor == UIColor.lightGray {
        textView.text = nil
        textView.textColor = UIColor.black
    }
}

  func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.isEmpty {
          textView.text = "Placeholder"
          textView.textColor = UIColor.lightGray
      }
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
