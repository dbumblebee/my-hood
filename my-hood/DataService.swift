//
//  DataService.swift
//  my-hood
//
//  Created by Brian Bresen on 11/10/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
        let postsData = NSKeyedArchiver.archivedData(withRootObject: _loadedPosts)
        UserDefaults.standard.set(postsData, forKey: KEY_POSTS)
        UserDefaults.standard.synchronize()
    }
    
    func loadPosts() {
        if let postsData = UserDefaults.standard.object(forKey: KEY_POSTS) as? NSData {
            if let postsArray = NSKeyedUnarchiver.unarchiveObject(with: postsData as Data) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: "postsLoaded"), object: nil))
    }
    func saveImageAndCreatePath(image: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate).png"
        let fullPath = documentsPathForFileName(name: imgPath)
        let fullURL = URL(fileURLWithPath: "file://\(fullPath)")
        
        //We should handle a failed write after the catch
        let tryWrite = try? imgData?.write(to: fullURL, options: Data.WritingOptions.atomic)

        return imgPath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(name: path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.appendingPathComponent(name)
    }
}
