//
//  ViewController.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 21.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let CellIdentifier = "MessageTextCell"
    private let SessionIdKey = "SessionId"
    
    private let signupURL = "http://52.192.101.131/signup"
    
    private let MaxMessageLengthInChars = 255
    private let BottomPadding:CGFloat = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: MessageTextView!
    @IBOutlet weak var messageEditorView: MessageEditorBackgroundView!
    
    @IBOutlet weak var messageTextFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageEditorBottomConstraint: NSLayoutConstraint!
    
    let imagePicker = UIImagePickerController()
    
    var messagesHolder = [MessageInfo]()
    var sessionId: String?
    
    @IBAction func selectPictureButtonTapped(sender: PictureSelectorButton) {
     imagePicker.allowsEditing = false
     imagePicker.sourceType = .PhotoLibrary
     
     presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        let threeLinesView = ThreeHorizontalLinesView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        let barButton = UIBarButtonItem(customView: threeLinesView)
        navigationItem.setLeftBarButtonItem(barButton, animated: false)
        
        imagePicker.delegate = self
        
        messageTextField.delegate = self
        messageTextField.textContainerInset = UIEdgeInsetsMake(8, 10, 8, 10)
        messageTextField.setNeedsDisplay()
        
        tableView.separatorStyle = .None
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        /*
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let savedSessionId = userDefaults.stringForKey(SessionIdKey) {
            sessionId = savedSessionId
            updateTable()
        } else {
            createNewSession()
        }
        */
        updateTable()
    }
    
    func createNewSession() {
        let url = NSURL(string: signupURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
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
                print(response)
                print(String(data: data, encoding: NSUTF8StringEncoding))
            } else {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func updateTable() {
        let message1 = MessageInfo(type: "text", date: NSDate(), sender: "me", isOwnMessage: true, text: "Hello, Sasha! It's really nice to meet you! And I hope this message will wider than table row", picture: nil)
        messagesHolder.append(message1)
        let message2 = MessageInfo(type: "text", date: NSDate(), sender: "sasha", isOwnMessage: false, text: "Hi, Jenya!", picture: "picture")
        messagesHolder.append(message2)
        messagesHolder.append(message1)
        messagesHolder.append(message2)
        messagesHolder.append(message1)
        messagesHolder.append(message2)
        tableView.reloadData()
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
        if tableView.frame.size.height > textView.intrinsicContentSize().height {
            messageTextFieldHeightConstraint.constant = textView.intrinsicContentSize().height
        }
        messageTextField.setNeedsDisplay()
        messageEditorView.setNeedsDisplay()
     }
     
     func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
          dismissViewControllerAnimated(true, completion: nil)
     }
     
     func imagePickerControllerDidCancel(picker: UIImagePickerController) {
          dismissViewControllerAnimated(true, completion: nil)
     }

}

