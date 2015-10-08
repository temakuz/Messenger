//
//  MessengerCollectionViewController.swift
//  Messenger
//
//  Created by Артем Кузнецов on 05.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CellMessage"

class MessengerViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var bottomConstraiteInputView: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!

    @IBAction func tapGesture(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func sendButton() {
        view.endEditing(true)
    }
    
    private var messages = [Message(message: "Hello, Mark:)", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Mark", lastName: "Levin", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:) d s gs dsg dfg sdfg dfsg d", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:) fsgj nj dfgb mndfb gmdnfbg df gbdfmnb ndmf", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artenb asnm bashdf vadshf gasdjhfg adjhfg kajsdhfg kajsdhfg kjadhsg fjsdhgf kjsadhm:) ", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextField.delegate = self

        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? CastomStyleCell {
            layout.delegate = self
        }
        
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 20, right: 5)

        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MessageCollectionViewCell
        cell.messageLable?.textColor = UIColor.blackColor().colorWithAlphaComponent(0.55)
        cell.messageLable?.text = messages[indexPath.row].message
        
        cell.usernameLable?.textColor = UIColor.blackColor().colorWithAlphaComponent(0.85)
        cell.usernameLable?.text = messages[indexPath.row].sender.firstName + "" + messages[indexPath.row].sender.lastName
        
        cell.messageView.positionView = indexPath.row % 2 == 0 ? .Right : .Left
        cell.messageView.setNeedsDisplay()
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView?.reloadData()
    }

    func keyboardDidShow(notification: NSNotification) {
        let info: NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.bottomConstraiteInputView.constant += keyboardHeight
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.bottomConstraiteInputView.constant = 5
            }, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        super.viewWillDisappear(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        messageTextField.resignFirstResponder()
        return true
    }
    
}


extension MessengerViewController: MessageLayoutDelegate {
    func collectionView(collectionView:UICollectionView, heightForMessageViewAtIndexPath indexPath:NSIndexPath, withWidth: CGFloat) -> CGFloat {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = messages[indexPath.row].message
        
        var labelFrame = label.frame
        labelFrame.size.width = withWidth
        label.frame = labelFrame
        label.sizeToFit()
        
        return label.frame.height
    }
    
    func collectioView(collectionView: UICollectionView, positionCellViewAtIndexPath indexPath: NSIndexPath) -> Int {
        return indexPath.row % 2 == 0 ? 0 : 1
            
    }
}
