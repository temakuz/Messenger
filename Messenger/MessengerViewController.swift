//
//  MessengerCollectionViewController.swift
//  Messenger
//
//  Created by Артем Кузнецов on 05.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CellMessage"

class MessengerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var inputMessageView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var bottomConstraiteInputView: NSLayoutConstraint!
    @IBOutlet weak var titleCollectionView: UINavigationItem!
    
    @IBAction func tapGesture(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func sendButton() {
        let date = NSDate()
        
        let message = Message(id: 0, message: messageTextField!.text, date: date, sender: senderUser.id, recipient: receiverUser.id)
        self.messages.append(message)
        
        collectionView.insertItemsAtIndexPaths([NSIndexPath(forRow: messages.count - 1, inSection: 0)])
        
        self.collectionView.setContentOffset(CGPoint(x: 0, y: self.collectionView.contentSize.height), animated: false)
        
        Messages.sendMessage(message, success: nil, failure: nil)
        
        messageTextField?.text = ""
        
        view.endEditing(true)
    }

    private var messages = [Message]()
    var array = [AnyObject]()

    private let senderUser = User(id: 6, username: "Artem Kuznetsov", image: nil)
    private let receiverUser = User(id: 1, username: "Mark Levin", image: nil)
    private var firstLoad = true
    
    private let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .ShortStyle
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? CastomStyleCell {
            layout.delegate = self
        }
        
        messageTextField.delegate = self
        
        collectionView!.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        titleCollectionView.title? = "Chat"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor(red: 139/255, green: 141/255, blue: 146/255, alpha: 1)]
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        loadMessages()
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
        
        cell.headerSubview?.removeFromSuperview()
        
        if messages[indexPath.row].sender == senderUser.id {
            let headerCell = DateView()
            
            cell.headerView.addSubview(headerCell)
            headerCell.dateLable?.text = dateFormatter.stringFromDate(messages[indexPath.row].date)
            cell.addHeaderView(headerCell)
            
            cell.messageView.positionView = .Right

        } else {
            cell.messageView.positionView = .Left
            let headerCell = UserInfoView()

            cell.headerView.addSubview(headerCell)
            headerCell.usernameLable?.text = receiverUser.username
            headerCell.dateLable?.text = dateFormatter.stringFromDate(messages[indexPath.row].date)
            cell.addHeaderView(headerCell)
        }
        cell.messageView.setNeedsDisplay()
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y

        if !firstLoad {
            if (currentOffset == 0) {
//                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                self.loadMessages()
            }
        }
    }

    func loadMessages() {
        var indexPaths = [NSIndexPath]()
        
        Messages.messagesUpdate(senderUser, toUser: receiverUser, offset: messages.count,
            success: { currentMessages in
                guard let newMessages = currentMessages?.reverse() else {
                    return
                }
                
                for (index, message) in newMessages.enumerate() {
                    indexPaths.append(NSIndexPath(forItem: index, inSection: 0))
                    self.messages.insert(message, atIndex: index)
                }
                
                let bottomOffset = self.collectionView.contentSize.height - self.collectionView.contentOffset.y

                if !self.firstLoad {
                    CATransaction.begin()
                    CATransaction.setDisableActions(true)
                }
                
                self.collectionView.performBatchUpdates({
                        self.collectionView.insertItemsAtIndexPaths(indexPaths)
                    },
                    completion: { complete in
                        if self.firstLoad {
                            self.firstLoad = false
                        } else {
                        
                        self.collectionView.setContentOffset(CGPoint(x: 0, y: self.collectionView.contentSize.height - bottomOffset), animated: false)
                        
                            CATransaction.commit()
                        }
                })

            }, failure: { error in
                print("Error")
        })
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {

        let info = notification.userInfo
        var keyboardSize = (info?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() ?? CGRectZero
        
        keyboardSize = view.convertRect(keyboardSize, fromView: nil)

        collectionView.contentOffset = CGPoint(x: 0, y: self.collectionView.contentSize.height - collectionView.bounds.height + collectionView.contentInset.bottom)
        
        collectionView.transform = CGAffineTransformMakeTranslation(0, -keyboardSize.size.height)
        inputMessageView.transform = CGAffineTransformMakeTranslation(0, -keyboardSize.size.height)
    }
    
    func keyboardWillHide(notification: NSNotification) {

        collectionView.transform = CGAffineTransformIdentity
        inputMessageView.transform = CGAffineTransformIdentity
    }
}

extension MessengerViewController: MessageLayoutDelegate {

    func collectionView(collectionView:UICollectionView, heightForMessageViewAtIndexPath indexPath:NSIndexPath, withWidth: CGFloat) -> CGFloat {
       
        let babbleView = MessageView()
        babbleView.messageLable?.text = messages[indexPath.row].message
        babbleView.messageLable.preferredMaxLayoutWidth = withWidth
        
        var labelFrame = babbleView.messageLable.frame
        labelFrame.size.width = withWidth
        babbleView.messageLable.frame = labelFrame
        babbleView.messageLable.sizeToFit()
        
        return babbleView.messageLable.frame.height
    }
    
    func collectioView(collectionView: UICollectionView, positionCellViewAtIndexPath indexPath: NSIndexPath) -> Int {
        return messages[indexPath.row].sender == senderUser.id ? 0 : 1
    }
}
