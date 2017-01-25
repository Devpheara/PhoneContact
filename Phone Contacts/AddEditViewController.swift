//
//  AddEditViewController.swift
//  Phone Contacts
//
//  Created by Eang Pheara on 1/4/17.
//  Copyright © 2017 Eang Pheara. All rights reserved.
//

import UIKit
import CoreData

class AddEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var pickerView : UIImagePickerController!
    
    var contact : Contact!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView = UIImagePickerController()
        pickerView.delegate = self
        if contact != nil{
            nameTextField.text = contact.name
            phoneTextField.text =  contact.phone
            emailTextField.text = contact.email
           
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func imagePickerView(_ sender: AnyObject) {
        present(pickerView, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = img
            
        }
        
        pickerView.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let contactService = ContactService(context: context)
        let picture = Contact(context: context)
        
        if let image = profileImageView.image {
            
            if let data = UIImageJPEGRepresentation(image, 0.8){
                
                let fileManager = FileManager.default
                
                let imageName = "\(UUID()).jpg"
                let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
                fileManager.createFile(atPath: path as String, contents: data, attributes: nil)
                print(path)
                picture.image = imageName
            }
            
            
        }
    
        
        
        
        if contact != nil{
            contact.name = nameTextField.text
            contact.phone =  phoneTextField.text
            contact.email = emailTextField.text
            contactService.update(updateContact: contact)
            
            //contacts.image = profileImageView.image
        }else{
            
            // Create
            
            _ = contactService.create(name: nameTextField.text!, phone: phoneTextField.text!, email: emailTextField.text!, image: picture.image!)
        }
        contactService.saveChange()
        _ = navigationController?.popViewController(animated: true)

    
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
