//
//  ViewController.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 21.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let CellIdentifier = "MessageTextCell"
    private let SessionIdKey = "SessionId"
    
    private let MaxMessageLengthInChars = 255
    private let BottomPadding:CGFloat = 0
    private let PageSize = 20
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageEditorView: MessageEditorBackgroundView!
    @IBOutlet weak var messageTextView: MessageTextView!
    
    @IBOutlet weak var messageEditorBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextViewHeightConstraint: NSLayoutConstraint!
     
    var messengerAPI = MessengerAPI()
    
    var messagesHolder = [Message]()
     var sessionId: String? {
          didSet {
               updateSession()
          }
     }
     
     var newestMessage:Message?
     var oldestMessage:Message?
     var currentUserId:Int?
    
    @IBAction func sendMessageButtonTapped(sender: UIButton) {
        if let messageText = messageTextView.text {
            if !messageText.isEmpty {
                let url = NSURL(string: "http://52.192.101.131/messages/message")!
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.HTTPBody = "{\"session\": \"\(sessionId!)\",  \"message\": {\"text\": \"\(messageText)\"}}".dataUsingEncoding(NSUTF8StringEncoding);
                
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request) { data, response, error in
                    dispatch_async(dispatch_get_main_queue()) {
                        if let _ = response, _ = data {
                            self.clearMessageEditor()
                            self.loadMessages(loadNewMessages: true)
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
     
          messengerAPI.viewController = self
        
          NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardDidShowNotification, object: nil)
          NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        let threeLinesView = ThreeHorizontalLinesView(frame: CGRect(x: 0, y: 0, width: 17, height: 15))
        let barButton = UIBarButtonItem(customView: threeLinesView)
        navigationItem.setLeftBarButtonItem(barButton, animated: false)
        
        messageTextView.delegate = self
        messageTextView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        messageTextView.setNeedsDisplay()
        
        tableView.transform = CGAffineTransformMakeScale(1, -1)
        tableView.separatorStyle = .None
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
     
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let savedSessionId = userDefaults.stringForKey(SessionIdKey) {
            sessionId = savedSessionId
        } else {
            messengerAPI.getNewSessionID()
        }
     

    }
     
     func saveNewSessionId(sessionId: String!) {
          let userDefaults = NSUserDefaults.standardUserDefaults()
          userDefaults.setValue(sessionId, forKey: self.SessionIdKey)
          self.sessionId = sessionId
     }
     
     func updateSession() {
          messengerAPI.updateSessionByID(sessionId!)
     }
     
     func didSessionUpdate(currentUserId userId:Int) {
          self.currentUserId = userId
          loadMessages(loadNewMessages: true)
     }
     
     func loadMessages(loadNewMessages loadNew:Bool) {
          let newestMessageId = loadNew ? newestMessage?.id : nil
          let oldestMessageId = loadNew ? nil : oldestMessage?.id
          messengerAPI.getMessagesPack(sessionId!, pagingSize: PageSize, newestMessageId: newestMessageId, oldestMessageId: oldestMessageId)
     }
     
     func handleMessages(messages messages:NSArray) {
          for message in messages {
               if let messageDictionary = message as? NSDictionary {
                    let newMessage = Message(serializedJsonObject: messageDictionary)
                    if isMessageLoaded(message: newMessage) {
                         continue
                    }
                    checkNewestMessage(message: newMessage)
                    checkOldestMessage(message: newMessage)
                    messagesHolder.append(newMessage)
               }
          }
          messagesHolder.sortInPlace { $0.date.compare($1.date) == .OrderedDescending }
          tableView.reloadData()
     }
     
     func isMessageLoaded(message newMessage:Message) -> Bool {
          for message in messagesHolder {
               if message.id == newMessage.id {
                    return true
               }
          }
          return false
     }
     
     func checkNewestMessage(message message:Message) {
          if let currentNewestMessage = newestMessage {
               if currentNewestMessage.date.compare(message.date) != .OrderedDescending {
                    newestMessage = message
               }
          } else {
               newestMessage = message
          }
          
     }
     
     func checkOldestMessage(message message:Message) {
          if let currentOldestMessage = oldestMessage {
               if currentOldestMessage.date.compare(message.date) == .OrderedDescending {
                    oldestMessage = message
               }
          } else {
               oldestMessage = message
          }
          
     }
    
    func updateTable() {
    }
    
    func clearMessageEditor() {
        messageTextView.text = ""
        messageTextView.setNeedsDisplay()
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

}

// MARK: - UITableViewDataSource
extension ViewController:UITableViewDataSource {
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return messagesHolder.count
     }
     
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! MessageTableViewCell
          
          let message = messagesHolder[indexPath.row]
          cell.setData(message, isOwnMessage: (message.userId == currentUserId))
          cell.transform = CGAffineTransformMakeScale(1, -1)
          
          if (indexPath.row == messagesHolder.count - 1) {
               loadMessages(loadNewMessages: false)
          }
          
          return cell
     }
}

// MARK: - UITableViewDelegate
extension ViewController:UITableViewDelegate {
}

// MARK: - UITextViewDelegate
extension ViewController:UITextViewDelegate {
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

