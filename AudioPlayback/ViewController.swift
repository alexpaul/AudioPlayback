//
//  ViewController.swift
//  AudioPlayback
//
//  Created by Alex Paul on 3/6/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    private var avAudioPlayer: AVAudioPlayer!
    
    private let audio1 = "MLKDreamSpeech"
    private let audio2 = "TheVeryHungryCaterpillar"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudio()
    }
    
    private func configureAudio() {
        guard let audioFilePath = Bundle.main.path(forResource: audio2, ofType: "mp3") else { print("file not found"); return }
        do {
            avAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFilePath))
            slider.maximumValue = Float(avAudioPlayer.duration)
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            print("duration: \(avAudioPlayer.duration)") // in seconds
        } catch {
            print("fail configuring audio player: \(error)")
        }
    }

    @IBAction func play(_ sender: UIButton) {
        guard let player = avAudioPlayer else { return }
        player.play()
    }
    
    @IBAction func pause(_ sender: UIButton) {
        guard let player = avAudioPlayer else { return }
        player.pause()
    }
    
    @IBAction func stop(_ sender: UIButton) {
        guard let player = avAudioPlayer else { return }
        player.stop()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        guard let player = avAudioPlayer else { return }
        player.currentTime = Double(slider.value)
    }
    
    @objc func updateSlider() {
        guard let player = avAudioPlayer else { return }
        slider.value = Float(player.currentTime)
    }
}



