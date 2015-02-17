//
//  DetailViewController.swift
//  MessageHubClient
//
//  Created by Troy Sultan on 2/12/15.
//  Copyright (c) 2015 Troy Sultan. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var messages = [
        Message(text: "hellohellohello", userName: "Troy"),
        Message(text: "heyooo", userName: "John")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let message = self.messages[indexPath.row]
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.text = "<\(message.userName)> \(message.text)"
        return cell
    }   
    
}

