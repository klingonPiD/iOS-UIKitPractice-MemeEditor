//
//  SentMemesCollectionViewController.swift
//  MeMePicker
//
//  Created by Theo on 6/16/15.
//  Copyright (c) 2015 pid. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDataSource,UICollectionViewDelegate{

    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemesCollectionViewCell", forIndexPath: indexPath) as! CustomSentMemesCollectionViewCell
        let sentMeme = self.memes[indexPath.row]
        // Set the name and image
        cell.memeTopLabel.text = sentMeme.topText
        cell.memeBottomLabel.text = sentMeme.bottomText
        cell.memeImageView?.image = sentMeme.memeImg
        
        return cell
        
    }



}
