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
    var helper: Helper!;
    
    // MARK: - Errors
    
    struct Alerts {
        static let RecordingSavingFailed = "Recording failed";
        static let RecordingSavingFailedMessage = "There has been an problem by saving your record. Please try again!";
    }
    
    // MARK: - View Helper
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(false);
        helper = Helper(self); // Init the Helper for Alerts
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        resetText();
    }
    
    // MARK - UI Helper Method
    
    func resetText() {
        recordingLabel.text = "Tap to Record";
    }
    
    func configureUI(_ recording: Bool) {
        stopRecordingButton.isHidden = !recording;
        stopRecordingButton.isEnabled = recording;
        recordButton.isHidden = recording;
        recordButton.isEnabled = !recording;
        recordingLabel.text = recording ?
            "Recording in progress..." : "Recording finished! Please wait...";
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
            helper.showAlert(Alerts.RecordingSavingFailed, message: Alerts.RecordingSavingFailedMessage);
            resetText();
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

