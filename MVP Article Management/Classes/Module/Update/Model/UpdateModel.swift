//
//  UpdateModel.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit
import Alamofire

class UpdateModel{
    
    var updatePresenterProtocol:UpdatePresenterProtocol? // object of class UpdatePresenterProtocol
    
    func uploadImage(image:UIImage){
        Alamofire.upload(multipartFormData: {
            data in // form of image that we gonna send
            let imageData = UIImageJPEGRepresentation(image, 1)
            data.append(imageData!, withName: "FILE", fileName: "image.jpg", mimeType: "image/jpg")
        }, usingThreshold: 0, to: URL(string: UPLOAD_URL)!, method: .post, headers: HEADERS, encodingCompletion: {
            result in
            switch result {
            case.success(let upload, _, _):
                upload.responseJSON(completionHandler: {
                    response in
                    if let value = response.result.value as? [String:AnyObject]{
                        let imageUrl = value["DATA"] as! String // get url of image from api
                        self.updatePresenterProtocol?.uploadImageComplet(imageUrl: imageUrl)
                    }
                })
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        })
    }
    
    func updateArticle(id:Int, title:String, desc:String, imgUrl:String){
        let param: Parameters = [
            "TITLE" : title,
            "DESCRIPTION": desc,
            "IMAGE": imgUrl
        ]
        print(param)
        Alamofire.request(URL(string: "\(ARTICLE_URL)/\(id)")!, method: .put, parameters: param, encoding: JSONEncoding.default, headers: HEADERS).responseJSON(completionHandler: {
            response in
            if let value = response.result.value as? [String:AnyObject]{
                
                // Tell presenter that the post is complete
                self.updatePresenterProtocol?.updateComplete(message: value["MESSAGE"] as! String)
            
                
            }
        })
    }
    
}
