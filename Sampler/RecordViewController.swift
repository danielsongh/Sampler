//
//  ViewController.swift
//  Sampler
//
//  Created by Daniel Song on 4/5/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func recordButton(sender: AnyObject) {
        print("record button pressed")
        recordButton.enabled = false
        recordLabel.text = "recording"
        stopButton.enabled = true
        
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        print("stop button pressed")
        recordButton.enabled = true
        recordLabel.text = "Tap to record"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
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


}

