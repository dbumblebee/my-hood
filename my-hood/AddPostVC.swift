//
//  AddPostVC.swift
//  my-hood
//
//  Created by Brian Bresen on 11/10/16.
//  Copyright © 2016 BeeHive Productions. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    @IBAction func makePostBtnPressed(_ sender: Any) {
        if let title = titleField.text, let desc = descField.text, let img = postImg.image {
            let imgPath = DataService.instance.saveImageAndCreatePath(image: img)
            let post = Post(imagePath: imgPath, title: title, description: desc)
            DataService.instance.addPost(post: post)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPicBtnPressed(_ sender: UIButton) {
        sender.setTitle("", for: .normal)
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            postImg.image = image
        }
        
    }
    
}
