//
//  UpdatePresenter.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit

class UpdatePresenter{
    var updateModel = UpdateModel()
    var updateTableViewProtocol: UpdateTableViewProtocol?
    
    init() {
        updateModel.updatePresenterProtocol = self
    }
    
    func uploadImage(image:UIImage){
        
        
        updateModel.uploadImage(image: image)
    }
    
    func updateArticle(id:Int, title:String, desc:String, imgUrl:String){
        // Pass data to updateModel
        updateModel.updateArticle(id: id, title: title, desc: desc, imgUrl: imgUrl)
    }
}

extension UpdatePresenter: UpdatePresenterProtocol{
    func updateComplete(message: String) {
        updateTableViewProtocol?.updateComplete(message: message)
    }

    func uploadImageComplet(imageUrl: String) {
        // pass image url to view
        updateTableViewProtocol?.uploadImageSucessWith(url: imageUrl)
    }
}
