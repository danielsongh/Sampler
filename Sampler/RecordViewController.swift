//
//  ViewController.swift
//  Sampler
//
//  Created by Daniel Song on 4/5/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit
import AVFoundation


class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    

    
    // Settings for setting up the audio recorder
    let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000.0,
        AVNumberOfChannelsKey: 1 as NSNumber,
        AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
    ]
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.enabled = false
        
        //Set up AVAudio Session
        audioSession = AVAudioSession.sharedInstance()
        
        
        
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        audioSession.requestRecordPermission(){
            [unowned self] (allowed: Bool) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                if allowed {
                    
                    //enable the button
                    print("i'm just here to print something")
                    
                    
                }
                else {
                    // Disable recording button
                    // Show Permission warning image instead
                    print("allow recording plz")
                }
            }
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        stopButton.enabled = false
    }
    
    @IBAction func recordButton(sender: AnyObject) {
        print("record button pressed")
        recordButton.enabled = false
        recordLabel.text = "recording"
        stopButton.enabled = true
        
        /*
         let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
         let recordingName = "recordedVoice.wav"
         let pathArray = [dirPath, recordingName]
         */
        
        //let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //print(filePath)
        
        //let audioURL = self.getAudioURL()
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        
        //     try! audioRecorder = AVAudioRecorder(URL: audioURL, settings: settings)
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        
        //This will allow recording to start as soon as possible?
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        print("stop button pressed")
        recordButton.enabled = true
        recordLabel.text = "Tap to record"
        
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(true)
    }
    
    func startRecording() {
        
        let audioURL = self.getAudioURL()
        print(audioURL.absoluteString)
        
    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            print("successfully finished recording")
        }
        else{
            print("nah not successful")
        }
        //get ready to segue to file list!!!!
    }
    
    
    
    // Returns paths to a writable directory within the app
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
    
    // This returns the audio URL (saved as recordedAudio.wav )
    
    func getAudioURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("recordedAudio.m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }
    
    
}

