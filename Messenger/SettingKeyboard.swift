////
////  SetingKeyboard.swift
////  Messenger
////
////  Created by Артем Кузнецов on 09.10.15.
////  Copyright © 2015 Артём Кузнецов. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension MessengerViewController: UITextFieldDelegate {
//    override func viewWillAppear(animated:Bool) {
//        super.viewWillAppear(animated)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
//    }
//
//
//    func keyboardWillShow(notification: NSNotification) {
////        if let userInfo = notification.userInfo {
////            guard let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() else {
////                return
////            }
////            
////            UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
////                self.bottomConstraiteInputView.constant += keyboardSize.height
////                }, completion: nil)
////        }
//        
//        let info = notification.userInfo
//        var keyboardSize = (info?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() ?? CGRectZero
//        
//        keyboardSize = view.convertRect(keyboardSize, fromView: nil)
//        
//        let oldInset = collectionView.contentInset
//        let insets = UIEdgeInsets(top: oldInset.top, left: oldInset.left, bottom: oldInset.bottom + keyboardSize.size.height, right: oldInset.right)
//        
//        collectionView.contentInset = insets
//        collectionView.scrollIndicatorInsets = insets
//        messageTextField.transform = CGAffineTransformMakeTranslation(0, -keyboardSize.size.height)
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
////        if let userInfo = notification.userInfo {
////            guard let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() else {
////                return
////            }
////            
////            UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
////                self.bottomConstraiteInputView.constant -= keyboardSize.height
////                }, completion: nil)
////        }
//        
//        
//        let topInset = self.topLayoutGuide.length
//        let insets = UIEdgeInsets(top: topInset, left: 0, bottom: CGRectGetHeight(messageTextField.frame), right: 0)
//        
//        collectionView.contentInset = insets
//        collectionView.scrollIndicatorInsets = insets
//        
//        messageTextField.transform = CGAffineTransformIdentity
//    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        messageTextField.resignFirstResponder()
//        return true
//    }
//}