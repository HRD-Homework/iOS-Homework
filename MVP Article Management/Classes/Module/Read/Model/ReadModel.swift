//
//  Read Model.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ReadModel{
    
    var readPresenterProtocol : ReadPresenterProtocol?
    
    func loadArticles(){
        
        // Create URL
        let url = URL(string: ARTICLE_URL)
        
        Alamofire.request(url!, method: .get
            , parameters: nil, encoding: URLEncoding.default, headers: HEADERS).responseArray(queue: nil, keyPath: "DATA", context: nil, completionHandler: {
                
                (response:DataResponse<[Article]>) in
                
                self.readPresenterProtocol?.responseData(data: response.result.value!)
            
        })
    }
    
    func deleteArticle(id : Int){
        // Create URL
        let url = URL(string: "\(ARTICLE_URL)/\(id)")
        Alamofire.request(url!, method: .delete, parameters: nil, encoding: URLEncoding.default, headers: HEADERS).responseJSON(completionHandler: {
            
            response in
            
            if let value = response.result.value as? [String:AnyObject]{
                if value["CODE"] as! String == "0000"{
                    print(value["MESSAGE"] as! String)
                    // Tell presenter that the delete operation is success
                    self.readPresenterProtocol?.deleteSuccess(message: value["MESSAGE"] as! String)
                }
            }
            
        })
    }
    
}



