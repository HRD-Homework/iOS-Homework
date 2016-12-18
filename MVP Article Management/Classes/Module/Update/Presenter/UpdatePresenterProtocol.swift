//
//  UpdatePresenterProtocol.swift
//  MVP Article Management
//
//  Created by Amreth on 12/17/16.
//  Copyright © 2016 Amreth. All rights reserved.
//

import Foundation

protocol UpdatePresenterProtocol{
    func uploadImageComplet(imageUrl: String)
    func updateComplete(message: String)
}
