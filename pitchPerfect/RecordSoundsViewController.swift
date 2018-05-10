//
//  ViewController.swift
//  pitchPerfect
//
//  Created by Michael Gohl on 26.04.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import UIKit

class RecorderViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBAction func recordAudio(_ sender: Any) {
        stopRecordingButton.isEnabled = true;
        recordButton.isEnabled = false;
        recordingLabel.text = "Recording in progress...";
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        stopRecordingButton.isEnabled = false;
        recordButton.isEnabled = true;
        recordingLabel.text = "Recording finished!";
    }
    
}

