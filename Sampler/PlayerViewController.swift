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
    

    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
   
    var trackURLToLoad: URL!
    
    @IBOutlet weak var playAudioButton: UIButton!
    @IBOutlet weak var stopAudioButton: UIButton!
    @IBAction func playAudioButtonTapped(_ sender: AnyObject) {
        playAudio()
    }
    
    @IBAction func stopAudioButtonTapped(_ sender: AnyObject) {
        stopAudio()
    }
    
    @IBOutlet weak var pitchSlider: UISlider!
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)

        sliderValueLabel.text = "\(currentValue)"
        
    }

    @IBOutlet weak var sliderValueLabel: UILabel!

    func playAudio(){
    
        do{
            audioFile = try AVAudioFile(forReading: trackURLToLoad)
        } catch{
            print("error setting up file")
        }
    
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFile!.processingFormat, frameCapacity: AVAudioFrameCount(audioFile!.length))
        
        do {
            try audioFile!.read(into: buffer)
        } catch _ {
        }
        
        audioEngine = AVAudioEngine()
        
        audioPlayerNode = AVAudioPlayerNode()
        audioPlayerNode.volume = 1
        audioEngine.attach(audioPlayerNode)
        
        let changeRatePitchNode = AVAudioUnitTimePitch()
        
        
        changeRatePitchNode.pitch = 1000
        changeRatePitchNode.rate = 1.5
        
        
        audioEngine.attach(changeRatePitchNode)
        
        
        
        audioEngine.connect(audioPlayerNode, to: changeRatePitchNode, format: buffer.format)
        audioEngine.connect(changeRatePitchNode, to: audioEngine.outputNode, format: buffer.format)
        

        audioPlayerNode.scheduleBuffer(buffer, at: nil, options: AVAudioPlayerNodeBufferOptions.loops, completionHandler: nil)
        
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
    
    
    
}
