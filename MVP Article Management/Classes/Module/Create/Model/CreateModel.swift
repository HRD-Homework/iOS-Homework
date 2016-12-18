//
//  CreateModel.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import UIKit
import Alamofire

class CreateModel{
    
    var createPresenterProtocol:CreatePresenterProtocol?
    
    func uploadImage(image:UIImage){
        
        Alamofire.upload(multipartFormData: { formData in
            
            // Create Image Data from image parameter
            let imageData = UIImagePNGRepresentation(image)
            // Appen imageData to formData
            formData.append(imageData!, withName: "FILE", fileName: "image.png", mimeType: "image/png")
            
        }, usingThreshold: 0, to: URL(string : UPLOAD_URL)!, method: .post, headers: HEADERS, encodingCompletion: {
        
            result in
            
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { response in
                    
                    if let value = response.result.value as? [String:AnyObject]{
                        if (value["CODE"] as! String) == "0000"{
                                // get image url
                            let imageUrl = value["DATA"] as! String
                            // Pass imageUrl to presenter delegate
                            self.createPresenterProtocol?.uploadImageSuccessWith(imageUrl: imageUrl)
                        }
                    }
                
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        })
        
    }
    
    func postArticle(title:String, description:String, imageUrl:String){
        let params : Parameters = [
            "TITLE": title,
            "DESCRIPTION": description,
            "AUTHOR": 0,
            "CATEGORY_ID": 0,
            "STATUS": "string",
            "IMAGE": imageUrl
        ]
        
        Alamofire.request(URL(string: ARTICLE_URL)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: HEADERS).responseJSON(completionHandler: { response in
            
            if let value = response.result.value as? [String:AnyObject]{
                if (value["CODE"] as! String) == "0000"{
                    // Tell presenter that the article is posted success
                    self.createPresenterProtocol?.postArticleSuccess()
                }
            }
            
        })
    }
    
    
    
}
