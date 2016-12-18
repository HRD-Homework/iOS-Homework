//
//  ReadPresenterProtocol.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import Foundation

protocol ReadPresenterProtocol {
    func responseData(data : [Article])
    func deleteSuccess(message:String)
}
