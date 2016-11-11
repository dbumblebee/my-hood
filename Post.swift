//
//  Post.swift
//  my-hood
//
//  Created by Brian Bresen on 11/10/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import Foundation

class Post: NSObject, NSCoding {
    
    private var _imagePath: String!
    private var _title: String!
    private var _postDesc: String!
    
    init(imagePath: String, title: String, description: String) {
        self._imagePath = imagePath
        self._title = title
        self._postDesc = description
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._imagePath = aDecoder.decodeObject(forKey: "imagePath") as? String
        self._title = aDecoder.decodeObject(forKey: "title") as? String
        self._postDesc = aDecoder.decodeObject(forKey: "description") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self._imagePath, forKey : "imagePath")
        aCoder.encode(self._imagePath, forKey : "title")
        aCoder.encode(self._imagePath, forKey : "description")
    }
    
    var imagePath: String {
        return _imagePath
    }
    
    var title: String {
        return _title
    }
    
    var postDesc: String {
        return _postDesc
    }
}
