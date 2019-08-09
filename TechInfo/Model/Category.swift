//
//  Category.swift
//  TechInfo
//
//  Created by Adel on 24/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation

struct Category {
    private(set)  public var title: String!
    private(set) public var imageName: String!
    
    init(title: String, imageName: String)  {
    self.title = title
    self.imageName = imageName
    }
}

