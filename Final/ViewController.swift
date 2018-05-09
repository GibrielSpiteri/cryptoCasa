//
//  ViewController.swift
//  Final
//
//  Created by Gibriel Spiteri on 4/30/18.
//  Copyright © 2018 Gibriel Spiteri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
 
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func nameField(_ sender: UITextField) {
    }
    @IBAction func addressField(_ sender: UITextField) {
    }
    @IBAction func zipcodeField(_ sender: UITextField) {
    }
    @IBAction func stateField(_ sender: UITextField) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData:Data = UIImagePNGRepresentation(image_data!)!
        _ = imageData.base64EncodedString()
        imageView.image = image_data
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Upload(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
}


