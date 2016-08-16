//
//  AudioURL.swift
//  Sampler
//
//  Created by Daniel Song on 8/14/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import Foundation

class AudioURL {
    
    
    
    // Return path to a writable directory within the app
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
    
    // Return the audio URL (saved as audio.caf )
    
    func getAudioURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("audio.caf")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
        
        //let audioURLString = audioURL.path!
        //return audioURLString
    }

    
    
}