//
//  UpdateTableViewController.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftSpinner


class UpdateTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // create outlet to get/set value to UIControl's properties in screen
    @IBOutlet weak var updateTitle: UITextField!
    @IBOutlet weak var updateImg: UIImageView!
    @IBOutlet weak var updateDes: UITextView!
    // create variable to store the article to update
    var artID:Int? // represent the id of article that we want to update
    var artTitle:String?
    var artDes:String?
    var imgUrl:String?
    
    // Create UpdatePresenter Object
    
    var updatePresenter: UpdatePresenter?
    
    
    
    @IBAction func btnBrosweUpdate(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    // after image is picked from photo library, then display image to image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // get pickedImage
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            updateImg.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSaveUpdate(_ sender: Any) {
        SwiftSpinner.show("updating...")
        // Pass image to presenter to upload
        let image = updateImg.image
        updatePresenter?.uploadImage(image:image!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePresenter = UpdatePresenter() // create object of Class UpdatePresenter
        updatePresenter?.updateTableViewProtocol = self
        updateTitle.text = artTitle
        updateDes.text = artDes
        if let imgUrl = imgUrl, let url = URL(string:imgUrl){
            
            updateImg.kf.setImage(with: url)
        }else{
            updateImg.image = #imageLiteral(resourceName: "unnamed")
        }
    }
}

extension UpdateTableViewController: UpdateTableViewProtocol{
    func uploadImageSucessWith(url: String) {
        // Pass data to presenter to update
        updatePresenter?.updateArticle(id: artID!, title: updateTitle.text!, desc: updateDes.text, imgUrl: url)
    }
    func updateComplete(message: String) {
        SwiftSpinner.hide()
        print(message)
        _ = navigationController?.popViewController(animated: true)
    }
    
}
