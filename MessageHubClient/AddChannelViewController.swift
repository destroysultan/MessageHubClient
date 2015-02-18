//
//  AddChannelViewController.swift
//  MessageHubClient
//
//  Created by Troy Sultan on 2/16/15.
//  Copyright (c) 2015 Troy Sultan. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {
   
    var delegate: AddChannelViewControllerDelegate?

    @IBOutlet weak var channelNameTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.channelNameTextView.becomeFirstResponder()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitChannelName(sender: AnyObject) {
        let channel = Channel(name: channelNameTextView.text)
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










