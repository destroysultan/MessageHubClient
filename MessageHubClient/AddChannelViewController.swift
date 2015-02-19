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
        self.delegate?.addChannelViewControllerDidCreateChannel(channel)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


protocol AddChannelViewControllerDelegate : NSObjectProtocol {
    func addChannelViewControllerDidCreateChannel(channel: Channel )
}










