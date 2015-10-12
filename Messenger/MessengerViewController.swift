//
//  MessengerCollectionViewController.swift
//  Messenger
//
//  Created by Артем Кузнецов on 05.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CellMessage"

class MessengerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var bottomConstraiteInputView: NSLayoutConstraint!
    
    @IBOutlet weak var titleCollectionView: UINavigationItem!
    
    var array = [AnyObject]()
    
    @IBAction func tapGesture(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func sendButton() {
        view.endEditing(true)
    }
    
    private var messages = [Message(message: "Hello, Mark:)", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Mark", lastName: "Levin", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:) d s gs dsg dfg sdfg dfsg d", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:) fsgj nj dfgb mndfb gmdnfbg df gbdfmnb ndmf", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, hgf kjsadhm:) ", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        messageTextField.delegate = self

        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? CastomStyleCell {
            layout.delegate = self
        }
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
        titleCollectionView.title? = "Chat"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor().colorWithAlphaComponent(0.55)]
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
        
        if indexPath.row % 2 == 0 {
            let headerCell = DateView()
            cell.headerView.addSubview(headerCell)
            headerCell.dateLable?.text = "24:00PM"
            cell.addHeaderView(headerCell)
            
            cell.messageView.positionView = .Right

        } else {
            cell.messageView.positionView = .Left
            let headerCell = UserInfoView()

            cell.headerView.addSubview(headerCell)
            headerCell.usernameLable?.text = "Artem"
            headerCell.dateLable?.text = "22:30PM"
            cell.addHeaderView(headerCell)
        }
        cell.messageView.setNeedsDisplay()
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView?.reloadData()
        let indexPath = NSIndexPath(forRow: messages.count - 1, inSection: 0)
        self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Top, animated: false)
        
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
        
        return label.frame.height + 2
    }
    
    func collectioView(collectionView: UICollectionView, positionCellViewAtIndexPath indexPath: NSIndexPath) -> Int {
        return indexPath.row % 2 == 0 ? 0 : 1
            
    }
}
