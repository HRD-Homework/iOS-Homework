//
//  InforAPI.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import Foundation
import Alamofire

let HEADERS : HTTPHeaders = ["Authorization":"Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]

let BASE_URL = "http://120.136.24.174:1301"

let ARTICLE_URL = BASE_URL + "/v1/api/articles"

let UPLOAD_URL = BASE_URL + "/v1/api/uploadfile/single"
