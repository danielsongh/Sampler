//
//  SampleList.swift
//  Sampler
//
//  Created by Daniel Song on 8/7/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import Foundation
import UIKit


struct Sample {
    var name: String?
    var date: NSDate
    
    
    init(name: String?, date: NSDate) {
        self.name = name
        self.date = NSDate()
    }
}