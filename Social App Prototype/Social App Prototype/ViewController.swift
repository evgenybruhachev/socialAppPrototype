//
//  ViewController.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 21.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    private let CellIdentifier = "MessageTextCell"
    private let SessionIdKey = "SessionId"
     
    private let signupURL = "http://52.192.101.131/signup"
    private let sendMessageURL = "http://52.192.101.131/messages/message"
    
    private let MaxMessageLengthInChars = 255
    private let BottomPadding:CGFloat = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageEditorView: MessageEditorBackgroundView!
    @IBOutlet weak var messageTextView: MessageTextView!
    
    @IBOutlet weak var messageEditorBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextViewHeightConstraint: NSLayoutConstraint!
    
    var messagesHolder = [MessageInfo]()
    var sessionId: String?
     
    var newestMessageId = 0
    var oldestMessageId = 0
    
    @IBAction func sendMessageButtonTapped(sender: UIButton) {
        if let messageText = messageTextView.text {
            if !messageText.isEmpty {
                let url = NSURL(string: "http://52.192.101.131/messages/message")!
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                request.HTTPBody = "{\n  \"session\": \"\(sessionId!)\",\n  \"message\": {\n    \"text\": \"\(messageText)\"\n  }\n}".dataUsingEncoding(NSUTF8StringEncoding);
                
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request) { data, response, error in
                    dispatch_async(dispatch_get_main_queue()) {
                        if let _ = response, _ = data {
                            self.clearMessageEditor()
                            self.updateTable()
                        } else {
                            print(error)
                        }
                    }
                }
                
                task.resume()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        let threeLinesView = ThreeHorizontalLinesView(frame: CGRect(x: 0, y: 0, width: 17, height: 15))
        let barButton = UIBarButtonItem(customView: threeLinesView)
        navigationItem.setLeftBarButtonItem(barButton, animated: false)
        
        messageTextView.delegate = self
        messageTextView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        messageTextView.setNeedsDisplay()
        
        tableView.separatorStyle = .None
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
     
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let savedSessionId = userDefaults.stringForKey(SessionIdKey) {
            sessionId = savedSessionId
            updateSession(sessionId!)
        } else {
            createNewSession()
        }
     

    }
    
    func createNewSession() {
          let url = NSURL(string: signupURL)!
          let request = NSMutableURLRequest(URL: url)
          request.HTTPMethod = "POST"
     
          let session = NSURLSession.sharedSession()
          let task = session.dataTaskWithRequest(request) { data, response, error in
               dispatch_async(dispatch_get_main_queue()) {
                    if let _ = response, data = data {
                         do {
                              let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                              if let sessionId = json["session"] as? String {
                                   let userDefaults = NSUserDefaults.standardUserDefaults()
                                   userDefaults.setValue(sessionId, forKey: self.SessionIdKey)
                                   self.sessionId = sessionId
                              }
                         } catch {
                              print("error serializing JSON: \(error)")
                         }
                         self.updateTable()
                    } else {
                         print(error)
                    }
               }
          }
        
        task.resume()
    }
     
     func updateSession(sessionId: String) {
          let url = NSURL(string: "http://52.192.101.131/session?session=\(sessionId)")!
          let request = NSMutableURLRequest(URL: url)
          request.HTTPMethod = "POST"
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          
          let session = NSURLSession.sharedSession()
          let task = session.dataTaskWithRequest(request) { data, response, error in
               dispatch_async(dispatch_get_main_queue()) {
                    if let _ = response, _ = data {
                         self.updateTable()
                    } else {
                         print(error)
                    }
               }
          }
          
          task.resume()
     }
     
     func loadMessages() {
          let url = NSURL(string: "http://52.192.101.131/messages")!
          let request = NSMutableURLRequest(URL: url)
          
          let session = NSURLSession.sharedSession()
          let task = session.dataTaskWithRequest(request) { data, response, error in
               dispatch_async(dispatch_get_main_queue()) {
                    if let response = response, data = data {
                         print(response)
                         print(String(data: data, encoding: NSUTF8StringEncoding))
                    } else {
                         print(error)
                    }
               }
          }
          
          task.resume()
     }
    
    func updateTable() {
        let message1 = MessageInfo(type: "text", date: NSDate(), sender: "me", isOwnMessage: false, text: "Lorem ipsum dolor sit amet, consect adipiscing elit.", picture: nil)
        messagesHolder.append(message1)
        let message2 = MessageInfo(type: "text", date: NSDate(), sender: "sasha", isOwnMessage: true, text: "Lorem ipsum dolor sit amet.", picture: nil)
        messagesHolder.append(message2)
        messagesHolder.append(message1)
        messagesHolder.append(message2)
        messagesHolder.append(message1)
        messagesHolder.append(message2)
        tableView.reloadData()
    }
    
    func clearMessageEditor() {/*
        messageTextField.text = ""
        messageTextField.setNeedsDisplay()*/
    }

    func keyboardWasShown(sender: NSNotification) {
        messageEditorBottomConstraint.constant = BottomPadding
        let info = sender.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.messageEditorBottomConstraint.constant = keyboardFrame.size.height
        })
    }
    
    func keyboardWillHide(sender: NSNotification) {
        messageEditorBottomConstraint.constant = BottomPadding
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
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = textView.text ?? ""
        let newString: NSString = currentString.stringByReplacingCharactersInRange(range, withString: text)
        return newString.length <= MaxMessageLengthInChars
    }
    
    func textViewDidChange(textView: UITextView) {
        messageTextViewHeightConstraint.constant = textView.intrinsicContentSize().height

        messageTextView.setNeedsDisplay()
        messageEditorView.setNeedsDisplay()
     }

}

