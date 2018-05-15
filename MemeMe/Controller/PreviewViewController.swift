//
//  PreviewViewController.swift
//  MemeMe
//
//  Created by Hiren Samtani on 14/05/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagePreview.image = meme.imageMemed
    }
    
    
    
    
    
    
}
