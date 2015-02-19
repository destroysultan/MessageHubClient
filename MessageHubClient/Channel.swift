//
//  Channel.swift
//  MessageHubClient
//
//  Created by Troy Sultan on 2/17/15.
//  Copyright (c) 2015 Troy Sultan. All rights reserved.
//

import UIKit

class Channel: NSObject {
    let channelName: String
    
    init(channelName : String){
        self.channelName = channelName
    }
}
