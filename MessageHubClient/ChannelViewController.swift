//
//  ChannelViewController.swift
//  MessageHubClient
//
//  Created by Troy Sultan on 2/12/15.
//  Copyright (c) 2015 Troy Sultan. All rights reserved.

import UIKit

class ChannelViewController: UITableViewController, AddChannelViewControllerDelegate {

    var channels = [] as Array<Channel>

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getChannels()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMessageListViewController" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let channelSelection = channels[indexPath.row] as Channel
                let detailViewController = segue.destinationViewController as DetailViewController
                detailViewController.channelName = channelSelection.channelName
            }
            
        } else if segue.identifier == "showAddChannelViewController" {
            let addChannelViewController = segue.destinationViewController as AddChannelViewController
            addChannelViewController.delegate = self
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let channel = channels[indexPath.row] as Channel
        cell.textLabel!.text = channel.channelName
        return cell
    }
    
    // MARK: - reference to delegate
    
    func addChannelViewControllerDidCreateChannel(channel: Channel) {
        channels.append(channel)
        tableView.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - GET Networking code
    
    // throwns an error on screen
    func alertWithError(error : NSError) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.description,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    // GET channels
    
    func getChannels() {
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "GET"
        request.URL = NSURL(string: "http://tradecraftmessagehub.com/sample/")
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                if let error = error {
                    self.alertWithError(error)
                } else if let channels = self.channelsFromNetworkResponseData(data) {
                    self.channels = channels
                    self.tableView.reloadData()
                }
            }
        })
        
        task.resume()
    }
    
    // Parse channel name from network response json
    
    func channelsFromNetworkResponseData(responseData : NSData) -> Array<Channel>? {
        var serializationError : NSError?
        let channelAPIDictionaries = NSJSONSerialization.JSONObjectWithData(
            responseData,
            options: nil,
            error: &serializationError
            ) as Array<Dictionary<String, String>>
        
        if let serializationError = serializationError {
            alertWithError(serializationError)
            return nil
        }
        
        var channels = channelAPIDictionaries.map({ (channelAPIDictionary) -> Channel in
            let channelToken = channelAPIDictionary["channel_token"]!
            return Channel(channelName: channelToken)
        })
        
        return channels
    }
    

}

