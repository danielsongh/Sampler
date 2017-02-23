//
//  AudioFile.swift
//  Sampler
//
//  Created by Daniel Song on 9/9/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import Foundation

/*
 *
 * THIS CLASS IS NOT BEING USED FOR NOW. WILL ADD LATER.
 * TABLEVIEW CELLS CURRENTLY ONLY DISPLAY FILE NAMES.
 */


class AuidoFile: NSObject{
    
    var name: String
    var date: Date
    var audioURL: URL
    
    init(name: String, date: Date, audioURL: URL){
        self.name = name
        self.date = date
        self.audioURL = audioURL
        
        super.init()
    }
    
}
