//
//  SecondRegistrationVC.swift
//  TechInfo
//
//  Created by Adel on 03/06/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth



class SecondRegistrationVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var companyNameTF: FloatingLabeledTextField!
    @IBOutlet weak var companyAdress: FloatingLabeledTextField!
    
    @IBOutlet weak var BankAccountTF: FloatingLabeledTextField!
    
    
    @IBOutlet weak var BankAccountPwdTF: FloatingLabeledTextField!
    
    @IBOutlet weak var ReturnBtn: UIButton!
    
    
    @IBAction func RegistrationBtn(_ sender: Any) {
       // print(Utilisateur)

        addArtist()

        
    }
    var imagePicker:UIImagePickerController!

    
    //var test = false
    var Utilisateur = [
                "email": "" as String,
                "password": "" as String,
                "familyName": "" as String,
                "name": "" as String,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameTF.delegate = self
        companyAdress.delegate = self
        BankAccountTF.delegate = self
        BankAccountPwdTF.delegate = self
        
        companyNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        companyAdress.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        BankAccountTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        BankAccountPwdTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
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
        
        ReturnBtn.isHidden = true
        ReturnBtn.addTarget(self, action:#selector(logout), for: .touchUpInside)
        
        
    }
    
    
   @IBAction func logout(sender: UIButton){
       let uid = Auth.auth().currentUser
        if uid != nil {
            try! Auth.auth().signOut()
        }
    }
    
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func textFieldChanged(_ target:UITextField) {
        let username = companyNameTF.text
        let email = companyAdress.text
        let password = BankAccountTF.text
        let adress = BankAccountTF.text
        let formFilled = username != nil && username != "" && email != nil && email != "" && password != nil && password != "" && adress != "" && adress != nil
        //setContinueButton(enabled: formFilled)
    }
    
    @objc func addArtist(){
        
        
      /*  Utilisateur["companyName"] = companyNameTF.text! as String
        Utilisateur["adress"] = companyAdress.text! as String
        Utilisateur["companyBankAccount"] = BankAccountTF.text! as String
        Utilisateur["companyBankAccountPwd"] = BankAccountPwdTF.text! as String*/

        
       // let dataBaseRef = Database.database().reference()
        
        //generating a new key inside artists node
        //and also getting the generated key
        /*    let key = dataBaseRef.childByAutoId().key
         
         //creating artist with the given values
         let user = ["id":key,
         "email": emailField.text! as String,
         "password": passxordField.text! as String,
         "adress": adressField.text! as String,
         "username": usernameField.text! as String
         ]
         */
        guard let company = companyNameTF.text else { return }
        guard let companyAdress = companyAdress.text else { return }
        guard let BankAccount = BankAccountTF.text else { return }
        guard let familyName = Utilisateur["familyName"] else { return }
        guard let name = Utilisateur["name"] else { return }
        guard let BankPwd = BankAccountPwdTF.text else { return }

        
        guard let image = profileImg.image else { return }
        
        Auth.auth().createUser(withEmail: Utilisateur["email"]!, password: Utilisateur["password"]!) { user, error in
            if error == nil && user != nil {
                
               self.ReturnBtn.isHidden = false
                print("user created")
                
                self.uploadProfileImage(image) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = name
                        changeRequest?.photoURL = url
                        
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfile(name: name, adress: companyAdress, profileImageURL: url!, familyName: familyName, companyName: company, bankAccount: BankAccount, bankAccountPwd: BankPwd){ success in
                                    if success {
                                        self.dismiss(animated: true, completion: nil)
                                    } else {
                                        print("1")
                                        self.resetForm()
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                                self.resetForm()
                                print("2")

                                
                            }
                        }
                    } else {
                        self.resetForm()
                        print("3")

                    }
                    
                }
               
                   self.signInDone()
                

                
            }}}
    
    func signInDone() {
      //DispatchQueue.main.async {
        let alert = UIAlertController(title: "Now You Are Registred", message: "Log In Now!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        //}
    }
    
    func resetForm() {
        let alert = UIAlertController(title: "Error signing up", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    

    
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("users/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
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
    
    
    func saveProfile(name:String, adress:String, profileImageURL:URL, familyName:String, companyName:String, bankAccount:String, bankAccountPwd:String , completion: @escaping ((_ success:Bool)->())) {
       
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        print(databaseRef)
        
        let userObject = [
            "first Name": name,
            "photoURL": profileImageURL.absoluteString,
            "adress": adress,
            "family Name": familyName,
            "company Name": companyName,
            "bank Account": bankAccount,
            "bank Account Pwd": bankAccountPwd
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

    }*/
    

}


extension SecondRegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
