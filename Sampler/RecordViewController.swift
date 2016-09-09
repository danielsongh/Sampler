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
    let filePath = AudioURL()
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
        
        
        let audioURL = filePath.getAudioURL()
        print(audioURL.absoluteString)
        
        do{
            try audioRecorder = AVAudioRecorder(URL: audioURL, settings: settings)
    
        }catch{
            print("error setting up recorder")
        }
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
        
        
    }
    
    func stopRecording(){
        audioRecorder.stop()
        //print(audioRecorder.url)
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
    

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            performSegueWithIdentifier("recordingStopped", sender: audioRecorder.url)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "recordingStopped"){
            let playerVC = segue.destinationViewController as! PlayerViewController
            
            let recorderAudioURL = sender as! NSURL
            
            playerVC.recordedAudioURL = recorderAudioURL
            //print("this audio is from recordingVC VC")
            //print(recorderAudioURL)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load!")
        updateUI(for: .Stopped)
    }
    
    


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        
    }
    
    
    
    
    
}

