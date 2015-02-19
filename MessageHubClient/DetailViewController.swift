//
//  DetailViewController.swift
//  MessageHubClient
//
//  Created by Troy Sultan on 2/12/15.
//  Copyright (c) 2015 Troy Sultan. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    
    var channelName: String!
    var messages = [Message(text: "hellohellohello", userName: "Troy"), Message(text: "heyooo", userName: "John")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessages()
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        
        let message = self.messages[messages.count - (indexPath.row + 1)]
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.text = "\(message.userName): \(message.text)"
        return cell
    }
    
    // GET  messages (adapting getChannels function)
    
    func getMessages() {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest()
        
        request.HTTPMethod = "GET"
        request.URL = NSURL(string: "http://tradecraftmessagehub.com/sample/\(channelName)")
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                if let error = error {
                    self.alertWithError(error)
                } else if let messages = self.messagesFromNetworkResponseData(data) {
                    self.messages = messages
                    self.tableView.reloadData()
                }
            }
        })
        
        task.resume()
    }
    
    // Parse channel name from network response json
    
    func messagesFromNetworkResponseData(responseData : NSData) -> Array<Message>? {
        var serializationError : NSError?
        let messageAPIDictionaries = NSJSONSerialization.JSONObjectWithData(
            responseData,
            options: nil,
            error: &serializationError
            ) as Array<Dictionary<String, String>>
        
        if let serializationError = serializationError {
            alertWithError(serializationError)
            return nil
        }
        
        var messages = messageAPIDictionaries.map({ (messageAPIDictionary) -> Message in
            let messageText = messageAPIDictionary["message_text"]!
            let userName = messageAPIDictionary["user_name"]!
            return Message(text: messageText, userName: userName)
        })
        
        return messages
    }
    
    // throwns an error on screen
    
    func alertWithError(error : NSError) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.description,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
