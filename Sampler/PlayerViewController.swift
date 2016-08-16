//
//  PlayerViewController.swift
//  Sampler
//
//  Created by Daniel Song on 8/14/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    
    @IBOutlet weak var playAudioButton: UIButton!
    @IBOutlet weak var stopAudioButton: UIButton!
    @IBAction func playAudioButtonTapped(sender: AnyObject) {
        print("play button tapped yo")
        playAudio()
    }
    
    @IBAction func stopAudioButtonTapped(sender: AnyObject) {
        print("stop button tapped yo")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       //rate rate: Float? = nil, pitch: Float? = nil
    func playAudio(){
        //setupAudio()
        do{
            audioFile = try AVAudioFile(forReading: recordedAudioURL)
        } catch{
            print("error setting up file")
        }
        print("Audio file ready")
        
        let buffer = AVAudioPCMBuffer(PCMFormat: audioFile!.processingFormat, frameCapacity: AVAudioFrameCount(audioFile!.length))
        do {
            try audioFile!.readIntoBuffer(buffer)
        } catch _ {
        }
        
        audioEngine = AVAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioPlayerNode.volume = 1
        audioEngine.attachNode(audioPlayerNode)
        
        let changeRatePitchNode = AVAudioUnitTimePitch()
        changeRatePitchNode.pitch = 1000
        changeRatePitchNode.rate = 1.5
        
        
        audioEngine.attachNode(changeRatePitchNode)
        
        
        
        audioEngine.connect(audioPlayerNode, to: changeRatePitchNode, format: buffer.format)
        audioEngine.connect(changeRatePitchNode, to: audioEngine.outputNode, format: buffer.format)
        

        audioPlayerNode.scheduleBuffer(buffer, atTime: nil, options: AVAudioPlayerNodeBufferOptions.Loops, completionHandler: nil)
        
        do{
            try audioEngine.start()
        } catch {
            print("audio engine starterror")
        }
        
        audioPlayerNode.play()
        
    }

    
    func stopAudio(){
        audioPlayerNode.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}