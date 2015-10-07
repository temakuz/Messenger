//
//  MessengerCollectionViewController.swift
//  Messenger
//
//  Created by Артем Кузнецов on 05.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CellMessage"

class MessengerCollectionViewController: UICollectionViewController {

    private var messages = [Message(message: "Hello, :)", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Mark ", lastName: "Levin", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil)), Message(message: "Hello, Artem:)", date: nil, sender: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil), recipient: User(firstName: "Artem ", lastName: "Kuznetsov", image: nil))]
    var count = 0
   
    @IBOutlet weak var constraintMessageWidth: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? CastomStyleCell {
            layout.delegate = self
        }
        
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return messages.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MessageCollectionViewCell
        
        cell.messageLable?.text = messages[indexPath.row].message
        cell.usernameLable?.text = messages[indexPath.row].sender.firstName + "" + messages[indexPath.row].sender.lastName

        cell.messageView.positionView = indexPath.row % 2 == 0 ? .Right : .Left
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Now that the collection view has appeared, then all the cells have been initialized
        // with their appropiate content. The view should then be reloaded with the newly
        // calculated sizes as well.
        collectionView?.reloadData()
    }
}


extension MessengerCollectionViewController: MessageLayoutDelegate {
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
