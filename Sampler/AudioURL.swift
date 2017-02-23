//
//  AudioURL.swift
//  Sampler
//
//  Created by Daniel Song on 8/14/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import Foundation

class AudioURL {
    
    var recordings: [URL]?
    var recordingsURLs: [URL]?
    
    // Return path to a writable directory within the app
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        
        return documentsDirectory as NSString
    }
    
    // Return the audio URL to be saved (saved as audio.caf )
    
    func getAudioURL() -> URL {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("audio.caf")
        let audioURL = URL(fileURLWithPath: audioFilename)
        
        return audioURL
        
    }
    
    // Create a list of recordings URLs using filemanager.
    func listRecordingsNames() {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            self.recordings = urls.filter( { (name: URL) -> Bool in
                return name.lastPathComponent.hasSuffix("caf")
            })
            
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("something went wrong")
        }
    }
    
    func listRecordingsURLs() {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            self.recordingsURLs = urls
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("something went wrong")
        }
        

    }


}
