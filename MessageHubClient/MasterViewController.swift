//
//  MasterViewController.swift
//  MessageHubClient
//
//  Created by Troy Sultan on 2/12/15.
//  Copyright (c) 2015 Troy Sultan. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, AddChannelViewControllerDelegate {

    var objects = [] as Array<Channel>


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMessageListViewController" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as Channel
                //TO-DO: provide appropriate data to DetailViewController
            }
        }
        
        else if segue.identifier == "showAddChannelViewController" {
            let addChannelViewController = segue.destinationViewController as AddChannelViewController
            addChannelViewController.delegate = self
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let channel = objects[indexPath.row] as Channel
        cell.textLabel!.text = channel.name
        return cell
    }

//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }

    
    // MARK: - AddChannelViewControllerDelegate
    
//    func insertNewObject(sender: AnyObject) {
//        objects.insertObject(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }
    
    func addChannelViewControllerDidCreateChannel(channel: Channel) {
        objects.append(channel)
        tableView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

