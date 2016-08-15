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
        playAudio(rate: 1.5, pitch: 1000)
    }
    
    @IBAction func stopAudioButtonTapped(sender: AnyObject) {
        print("stop button tapped yo")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupAudio()
        
        print(recordedAudioURL)
        print("finished setting up audio")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAudio(){
        do{
            audioFile = try AVAudioFile(forReading: recordedAudioURL)
        } catch{
            print("error setting up file")
        }
        print("Audio file ready")
    }
    
    func playAudio(rate rate: Float? = nil, pitch: Float? = nil){
        audioEngine = AVAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changeRatePitchNode = AVAudioUnitTimePitch()
        if let pitch = pitch{
            changeRatePitchNode.pitch = pitch
        }
        if let rate = rate{
            changeRatePitchNode.rate = rate
        }
    
       audioEngine.attachNode(changeRatePitchNode)
        
        

        audioEngine.connect(audioPlayerNode, to: changeRatePitchNode, format: nil)
        audioEngine.connect(changeRatePitchNode, to: audioEngine.outputNode, format: nil)
    
        connectAudioNodes(audioPlayerNode, changeRatePitchNode, audioEngine.outputNode)
        audioPlayerNode.stop()
       audioPlayerNode.scheduleFile(audioFile, atTime: nil) {
            
            var delayInSeconds: Double = 0
            
            if let lastRenderTime = self.audioPlayerNode.lastRenderTime, let playerTime = self.audioPlayerNode.playerTimeForNodeTime(lastRenderTime) {
                
                if let rate = rate {
                    delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate) / Double(rate)
                } else {
                    delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate)
                }
            }
            
            // schedule a stop timer for when audio finishes playing
            self.stopTimer = NSTimer(timeInterval: delayInSeconds, target: self, selector: "stopAudio", userInfo: nil, repeats: false)
            NSRunLoop.mainRunLoop().addTimer(self.stopTimer!, forMode: NSDefaultRunLoopMode)
        }

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
    

    func connectAudioNodes(nodes: AVAudioNode...) {
        for x in 0..<nodes.count-1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
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