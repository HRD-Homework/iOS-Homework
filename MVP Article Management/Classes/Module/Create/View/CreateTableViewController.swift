//
//  CreateTableViewController.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit
import SwiftSpinner

class CreateTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var createTitle: UITextField!
    @IBOutlet weak var createImg: UIImageView!
    @IBOutlet weak var createDes: UITextView!
    
    var createPresenter:CreatePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPresenter = CreatePresenter()
        createPresenter?.createTableViewProtocol = self
    }
    
    
    @IBAction func btnBrowse(_ sender: Any) {
        // Browse Image from PhotoLibrary
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get picked image
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            // set picked image to imageView
            createImg.image = pickedImage
        }
        // hide picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        SwiftSpinner.show("Adding...")
        // Upload Image First
        // Tell presenter to upload image for me
        createPresenter?.uploadImage(image: createImg.image!)
        
    }
        
}

extension CreateTableViewController : CreateTableViewProtocol{
    func uploadImageSuccessWith(imageUrl: String) {
        // Start to post article
        // Call Presenter to post article
        createPresenter?.postArticle(title: createTitle.text!, description: createDes.text!, imageUrl: imageUrl)
    }
    
    func postArticleSuccess() {
        // exit create screen
        SwiftSpinner.hide()
        _ = navigationController?.popViewController(animated: true)
    }
}
