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
    let settings = [ AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
                    AVSampleRateKey: 32000.0,
                    AVNumberOfChannelsKey: 1 as NSNumber,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                    ] as [String : Any]
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func recordButton(_ sender: AnyObject) {
        print("record button pressed")
        updateUI(for: .recording)
        startRecording()
    }

    @IBAction func stopButton(_ sender: AnyObject) {
        print("stop button pressed")
        updateUI(for: .stopped)
        stopRecording()
    }
    
    func startRecording(){
        let recordingSession = AVAudioSession.sharedInstance()
        try! recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        let audioURL = filePath.getAudioURL()
        print(audioURL.absoluteString)
        do{
            try audioRecorder = AVAudioRecorder(url: audioURL as URL, settings: settings)
    
        }catch{
            print("error setting up recorder")
        }
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
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
        case .stopped:
            recordButton.isEnabled = true
            stopButton.isEnabled = false
        case .recording:
            recordButton.isEnabled = false
            stopButton.isEnabled = true
        default:
            break
        }
    }
    

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            performSegue(withIdentifier: "recordingStopped", sender: audioRecorder.url)
        }
    }
    

   /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "recordingStopped"){
            let playerVC = segue.destinationViewController as! PlayerViewController
            
            let recorderAudioURL = sender as! NSURL
            
            playerVC.recordedAudioURL = recorderAudioURL
            //print("this audio is from recordingVC VC")
            //print(recorderAudioURL)
        }

    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load!")
        updateUI(for: .stopped)
    }
}

