//
//  RecordSoundsViewController.swift
//  pitchPerfect
//
//  Created by Michael Gohl on 26.04.18.
//  Copyright © 2018 Michael Gohl. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false;
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        recordingLabel.text = "Tap to Record";
        
    }
    
    // MARK - UI Helper Method
    
    func configureUI(_ recording: Bool) {
        stopRecordingButton.isEnabled = recording;
        recordButton.isEnabled = !recording;
        recordingLabel.text = recording ?
            "Recording in progress..." : "Recording finished!";
    }
    
    // MARK: - Button Actions
    
    @IBAction func recordAudio(_ sender: Any) {
        configureUI(true);
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self;
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(false);
        audioRecorder.stop();
        let audioSession = AVAudioSession.sharedInstance();
        try! audioSession.setActive(false);
        
    }
    
    // MARK: - Audio Recorder Delegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Ohhhhhh nooooooo")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let audioURL = sender as! URL;
            playSoundsVC.recordedAudioUrl = audioURL;
        }
    }
    
}

