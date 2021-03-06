//
//  PlaySoundsViewController.swift
//  pitchPerfect
//
//  Created by Michael Gohl on 08.05.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import UIKit
import AVFoundation;

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioUrl: URL!;
    @IBOutlet weak var slowButton: UIButton!;
    @IBOutlet weak var fastButton: UIButton!;
    @IBOutlet weak var highButton: UIButton!;
    @IBOutlet weak var lowButton: UIButton!;
    @IBOutlet weak var echoButton: UIButton!;
    @IBOutlet weak var reverbButton: UIButton!;
    @IBOutlet weak var stopButton: UIButton!;
    
    var helper: Helper!;
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying);
        slowButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        fastButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        highButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        lowButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        helper = Helper(self);
        setupAudio()
    }

    // MARK: Play Audio and Stop
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(sender.tag) {
        case 0:
            playSound(rate: 0.5)
            break;
        case 1:
            playSound(rate: 1.5)
            break;
        case 2:
            playSound(pitch: 1000)
            break;
        case 3:
            playSound(pitch: -1000)
            break;
        case 4:
            playSound(echo: true)
            break;
        case 5:
            playSound(reverb: true)
            break;
        default:
            break
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio();
    }
    

}
