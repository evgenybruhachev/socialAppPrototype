//
//  ViewController.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 21.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let CellIdentifier = "MessageCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var messagesHolder:[MessageInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .None
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let message1 = MessageInfo(type: "text", date: NSDate(), sender: "me", isOwnMessage: true, text: "Hello, Sasha! It's really nice to meet you! And I hope this message will wider than table row", picture: nil)
        messagesHolder.append(message1)
        let message2 = MessageInfo(type: "text", date: NSDate(), sender: "sasha", isOwnMessage: false, text: "Hi, Jenya!", picture: nil)
        messagesHolder.append(message2)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesHolder.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! MessageTableViewCell
        
        let message = messagesHolder[indexPath.row]
        cell.setData(message, isOwnMessage: message.isOwnMessage)
        
        return cell
    }

}

