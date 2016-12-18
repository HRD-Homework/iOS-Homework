//
//  CreatePresenter.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit

class CreatePresenter{
    
    var createModel : CreateModel?
    var createTableViewProtocol:CreateTableViewProtocol?
    
    init() {
        createModel = CreateModel()
        // SEt Delegate
        createModel?.createPresenterProtocol = self
    }
    
    func uploadImage(image:UIImage){
        // Tell Model to upload image for me
        createModel?.uploadImage(image: image)
    }
    
    func postArticle(title:String, description:String, imageUrl:String){
        // Call Model to post article
        createModel?.postArticle(title: title, description: description, imageUrl: imageUrl)
    }
    
}

extension CreatePresenter : CreatePresenterProtocol{
    func uploadImageSuccessWith(imageUrl: String) {
        // Pass imageUrl to view
        createTableViewProtocol?.uploadImageSuccessWith(imageUrl: imageUrl)
    }
    
    func postArticleSuccess() {
        // Tell view
        createTableViewProtocol?.postArticleSuccess()
    }
}
