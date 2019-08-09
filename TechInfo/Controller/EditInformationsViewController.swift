//
//  EditInformationsViewController.swift
//  TechInfo
//
//  Created by Adel on 30/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class EditInformationsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var editCompanyName: UITextField!
    @IBOutlet weak var editCompanyAdress: UITextField!
    @IBOutlet weak var editCompanyEmail: UITextField!
    @IBOutlet weak var editCompanyPhone: UITextField!
    var x = false
    var imagePicker:UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editCompanyName.delegate = self
        editCompanyAdress.delegate = self
        editCompanyEmail.delegate = self
        editCompanyPhone.delegate = self

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(imageTap)
        profileImg.layer.cornerRadius = profileImg.bounds.height / 2
        profileImg.clipsToBounds = true
        //tapToChangeProfileButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    @IBAction func updateInfo(_ sender: Any) {
      //  resetForm()
        addArtist()
        
    }
    
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }


func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let storageRef = Storage.storage().reference().child("users/\(uid)/images")
    
    guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
    
    
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    storageRef.delete { error in
        if let error = error {
print(error)
            
        } else {
print("succefuly deleted")        }
    }

    storageRef.putData(imageData, metadata: metaData) { metaData, error in
        if error == nil, metaData != nil {
            storageRef.downloadURL { url, error in
                completion(url)
                print("image uploaded")
            }
        } else {
            // failed
            completion(nil)
        }
    }
}
    
    @objc func addArtist() {

    guard let company = editCompanyName.text else { return }
    guard let companyAdress = editCompanyAdress.text else { return }
    guard let BankAccount = editCompanyEmail.text else { return }
    guard let BankPwd = editCompanyPhone.text else { return }
    
    
    guard let image = profileImg.image else { return }
    

            
            self.uploadProfileImage(image) { url in
                
                if url != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    //changeRequest?.displayName = name
                    changeRequest?.photoURL = url
                    
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            print("User display name changed!")
                            
                            self.saveProfile( adress: companyAdress, profileImageURL: url!, companyName: company, bankAccount: BankAccount, bankAccountPwd: BankPwd){ success in
                                if success {
                                    
                                   // self.x = true
                                    print("success")
                                   // self.resetForm()
                                    //self.dismiss(animated: true, completion: nil)
                                } else {
                                    print("1")
                                }
                            }
                            
                        } else {
                            print("Error: \(error!.localizedDescription)")
                            print("2")
                        }
                    }
                } else {
                    
                    print("3")
                }
                
        }
            
        }
    func resetForm() {
        let alert = UIAlertController(title: "Your informations were successfuly edited ", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)/*
        let alertController = UIAlertController(title: "Yeah!", message: "Success", preferredStyle: UIAlertController.Style.alert)
        let actionPreview = UIAlertAction(title: "Preview it", style: UIAlertAction.Style.default)
        alertController.addAction(actionPreview)
        self.present(alertController, animated: true, completion: nil)*/
        
    }


func saveProfile( adress:String, profileImageURL:URL, companyName:String, bankAccount:String, bankAccountPwd:String , completion: @escaping ((_ success:Bool)->())) {
    
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    let databaseRef = Database.database().reference()//child("users/profile/\(uid)")
    print(databaseRef)
    
    let userObject = [
        
        "photoURL": profileImageURL.absoluteString,
        "adress": adress,
        "company Name": companyName,
        "company Phone": bankAccountPwd,
        "company Email": bankAccount
        ] as [String:Any]
    let childUpdates = ["users/profile/\(uid)": userObject]
  databaseRef.updateChildValues(childUpdates)
    self.resetForm()
   /* databaseRef.setValue(userObject) { error, ref in
        completion(error == nil)
    }*/
}

}

extension EditInformationsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            //profileImg.image = pickedImage
        }
        self.profileImg.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}
