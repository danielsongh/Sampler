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
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func recordButton(sender: AnyObject) {
        print("record button pressed")
        recordButton.enabled = false
        recordLabel.text = "recording"
        stopButton.enabled = true
        
        /*
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        */
        let audioURL = self.getAudioURL()
        
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]

        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        
        try! audioRecorder = AVAudioRecorder(URL: audioURL, settings: recordSettings)
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        print("stop button pressed")
        recordButton.enabled = true
        recordLabel.text = "Tap to record"
        
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        stopButton.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished recording... and saving???")
        
        //get ready to segue to audio editing!!!!
    
        
    }
    
    
    // Returns paths to a writable directory within the app
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
    
    // This returns the audio URL (saved as recordedAudio.wav )
    
    func getAudioURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("recordedAudio.wav")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }


}

