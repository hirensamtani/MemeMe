//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Hiren Samtani on 02/05/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let keyboardMoveListener = KeyboardMoveListener()
    let textTopDelegate = MemeTextFieldDelegate()
    let textBottomDelegate = MemeTextFieldDelegate()
    
    var meme = Meme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        
        
        initTextField(element: textTop, text: meme.textTop, delegate: textTopDelegate)
        initTextField(element: textBottom, text: meme.textBottom, delegate: textBottomDelegate)
        
        disableShareButton()
    }
    
    
    
    func initTextField(element: UITextField, text: String, delegate: UITextFieldDelegate) {
        
        let memeTextAttributes:[String: Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -3.0
        ]
        
        
        
        element.text = text
        element.delegate = delegate
        element.defaultTextAttributes = memeTextAttributes
        element.textAlignment = NSTextAlignment.center
        
    }
    
    func presentImagePickerWith(_ inpSourceType : UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = inpSourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePickerWith(.camera)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        presentImagePickerWith(.photoLibrary)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            enableShareButton()
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        keyboardMoveListener.subscribe(view: view, elements: [textBottom])
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        keyboardMoveListener.unsubscribe()
        
    }
    
    
    func saveMemedImage(_ image : UIImage) {
        meme.textTop = textTop.text!
        meme.textBottom = textBottom.text!
        meme.imageOriginal = imagePickerView.image!
        meme.imageMemed = image
        
        
        
    }
    
    func generateMemedImage() -> UIImage {
        
        topToolBar.isHidden = true
        bottomToolBar.isHidden = true
        
        
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolBar.isHidden = false
        bottomToolBar.isHidden = false
        
        return memedImage
    }
    
    @IBAction func cancelEdit(_ sender: Any) {
        let alert = UIAlertController(title: "Do you really want to cancel editing?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            self.initView()
            }
        )
        
        alert.addAction(UIAlertAction(title: "Keep Editing", style: .default) { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            }
        )
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func shareMemedImage(_ sender: Any) {
        
        let image = generateMemedImage() ;
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        controller.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) -> () in
            if (completed) {
                self.saveMemedImage(image)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(controller, animated: true, completion: nil)
        
        
        
    }
    
    
    func disableShareButton() {
        shareButton.isEnabled = false
    }
    
    func enableShareButton() {
        shareButton.isEnabled = true
    }
    
    func initView() {
        disableShareButton()
        textTop.text = "TOP"
        textBottom.text = "BOTTOM"
        
        textTopDelegate.isDefaultText = true
        textBottomDelegate.isDefaultText = true
        
        imagePickerView.image = nil
    }
    
}

