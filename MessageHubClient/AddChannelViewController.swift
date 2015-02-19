//
//  AddChannelViewController.swift
//  MessageHubClient
//
//  Created by Troy Sultan on 2/16/15.
//  Copyright (c) 2015 Troy Sultan. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController, UITextViewDelegate {
   
    var delegate: AddChannelViewControllerDelegate?

    @IBOutlet weak var channelNameTextView: UITextView!
    
    var placeholderLabel : UILabel!
    
    override func viewDidLoad() {
        self.channelNameTextView.becomeFirstResponder()
        channelNameTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Add new chat topic"
        placeholderLabel.font = UIFont.italicSystemFontOfSize(channelNameTextView.font.pointSize)
        placeholderLabel.sizeToFit()
        channelNameTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPointMake(5, channelNameTextView.font.pointSize / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.hidden = countElements(channelNameTextView.text) != 0
    }
    
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = countElements(textView.text) != 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitChannelName(sender: AnyObject) {
        let channel = Channel(channelName: channelNameTextView.text)
        
        if channel == "" {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            postNewChannel(channel)
        }
    
        self.delegate?.addChannelViewControllerDidCreateChannel(channel)
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

    // POST Networking code
    
    func postNewChannel(newChannel: Channel) {
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "http://tradecraftmessagehub.com/sample/\(newChannel.channelName)")
        
        var dataDictionary = ["user_name":"troy", "message_text":"new channel created!"] as Dictionary<String, String>
        var err: NSError?
        var requestBodyData = NSJSONSerialization.dataWithJSONObject(dataDictionary, options: nil, error: &err)
        
        request.HTTPBody = requestBodyData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                if let error = error {
                    self.alertWithError(error)
                } else {
                    println(response)
                    println(data)
                    // refresh channels list
                    self.delegate?.addChannelViewControllerDidCreateChannel(newChannel)
                }
            }
        })
        
        task.resume()
    }
}

// Delegate

protocol AddChannelViewControllerDelegate : NSObjectProtocol {
    func addChannelViewControllerDidCreateChannel(channel: Channel )
}










