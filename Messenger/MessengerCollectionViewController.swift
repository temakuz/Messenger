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
    
    private var messages = ["Lorem ipsum dolor sit amet.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed massa leo, mollis id tortor at posuere.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque semper vitae mi vel hendrerit. Suspendisse et feugiat mi. Donec quis sollicitudin quam, non porttitor nulla. Phasellus in luctus lorem, sed auctor enim. Suspendisse potenti. Ut maximus pharetra diam, ac laoreet est dignissim eu nullam."
    ]
    
    @IBOutlet weak var constraintMessageWidth: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
        cell.messageView.inputMessage = false
        cell.messageLable?.text = messages[indexPath.row]

        
        // Configure the cell
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

