//
//  RecordViewController.swift
//  Sampler
//
//  Created by Daniel Song on 4/5/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit
import AVFoundation



class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    let settings = [
        AVFormatIDKey: NSNumber(unsignedInt:kAudioFormatAppleLossless),
        AVSampleRateKey: 32000.0,
        AVNumberOfChannelsKey: 1 as NSNumber,
        AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
    ]
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    @IBAction func recordButton(sender: AnyObject) {
        print("record button pressed")
        updateUI(for: .Recording)
        startRecording()
        
        
    }
    
    
    @IBAction func stopButton(sender: AnyObject) {
        print("stop button pressed")
        updateUI(for: .Stopped)
        stopRecording()
        
    }
    
    
    func startRecording(){
        let recordingSession = AVAudioSession.sharedInstance()
        try! recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        //request permission?
        
        
        let audioURL = getAudioURL()
        print(audioURL.absoluteString)
        
        do{
            try audioRecorder = AVAudioRecorder(URL: audioURL, settings: settings)
            try audioRecorder.delegate = self
            try audioRecorder.meteringEnabled = true
            try audioRecorder.record()
            
        }catch{
            print("error setting up recorder")
        }
        
    }
    
    func stopRecording(){
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    
    func updateUI(for state: AudioState){
        switch(state){
        case .Stopped:
            recordButton.enabled = true
            stopButton.enabled = false
        case .Recording:
            recordButton.enabled = false
            stopButton.enabled = true
        default:
            break
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load!")
        updateUI(for: .Stopped)
    }
    
    
    
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

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        
    }
    
    
    
    
    
}

