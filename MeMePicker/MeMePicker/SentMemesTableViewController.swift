//
//  SentMemesTableViewController.swift
//  MeMePicker
//
//  Created by Theo on 6/10/15.
//  Copyright (c) 2015 pid. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //println(self.memes.count)
        return self.memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //println("reached cellforrow")
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableCell") as! UITableViewCell
        let sentMeme = self.memes[indexPath.row]
        //println(sentMeme.topText)
        cell.textLabel?.text = sentMeme.topText
        //let imageView = UIImageView(image: sentMeme.memeImg)
        //cell.backgroundView = imageView
        cell.imageView?.image = sentMeme.memeImg
        return cell
    }
    
}
