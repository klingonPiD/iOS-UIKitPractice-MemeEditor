//
//  ViewController.swift
//  MeMePicker
//
//  Created by Theo on 5/27/15.
//  Copyright (c) 2015 pid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pickImageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIButton!
    
    var meme : Meme!
    
    let memeTextFieldDelegate = MemeTextFieldDelgate()
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        topTextField.text = "TOP"
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        topTextField.delegate = memeTextFieldDelegate
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.delegate = memeTextFieldDelegate
        
        shareButton.enabled = false
        //meme = Meme()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.blackColor()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
    }

    
    @IBAction func OnPickImage(sender: UIBarButtonItem) {
        shareButton.enabled = true
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickController, animated: true, completion: nil)
    }
    
    @IBAction func OnPickImageFromCamera(sender: UIBarButtonItem) {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(pickController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.pickImageView.image = image
            //self.pickImageView.contentMode = UIViewContentMode.Center
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y -= getKeyBoardHeight(notification)
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        self.view.frame.origin.y += getKeyBoardHeight(notification)
    }
    
    func getKeyBoardHeight(notification : NSNotification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func unsubscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func generateMemedImage() -> UIImage
    {
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    @IBAction func onShareImage(sender: UIButton) {
        save()
        let activityViewController = UIActivityViewController(activityItems: [meme.memeImg], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        //activityViewController.completionWithItemsHandler = {}
    }
    
    //create, initialize and save meme object
    func save(){
        meme = Meme()
        meme.topText = topTextField.text
        meme.bottomText = bottomTextField.text
        meme.origImg = pickImageView.image
        meme.memeImg = generateMemedImage()
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }


}

