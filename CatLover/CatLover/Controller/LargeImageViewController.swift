//
//  LargeImageViewController.swift
//  CatLover
//
//  Created by Bruno Maciel on 7/3/20.
//  Copyright © 2020 Bruno Maciel. All rights reserved.
//

import UIKit

class LargeImageViewController: UIViewController {
    
    @IBOutlet weak var imageView_larger: UIImageView!
    
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView_larger.image = image
    }
    
    @IBAction func closeScreen(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
