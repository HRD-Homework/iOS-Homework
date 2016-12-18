//
//  ReadPresenter.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import Foundation

class ReadPresenter{
    
    var readModel = ReadModel()
    var readTableViewControllerProtocol : ReadTableViewControllerProtocol?
    
    init(){
        readModel.readPresenterProtocol = self
    }
    
    func loadArticles(){
        // load article from model
        readModel.loadArticles()
    }
    
    func deleteArticle(id : Int){
        // Tell model to delete article
        readModel.deleteArticle(id: id)
    }
    
}

extension ReadPresenter : ReadPresenterProtocol{
    func responseData(data: [Article]) {
        readTableViewControllerProtocol?.responseData(data: data)
    }
    
    func deleteSuccess(message: String) {
        // Tell view that the delete operation is sucess
        readTableViewControllerProtocol?.deleteSuccess(message: message)
    }
}
