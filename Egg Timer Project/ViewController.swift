//
//  ViewController.swift
//  Egg Timer Project
//
//  Created by See Sight Tours on 19/04/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    // soft = 300 , Medium = 420, Hard = 720 (seconds)
    let eggTimes = [ "Soft": 300, "Medium": 420, "Hard": 720 ]
    var secondsRemaining = 60
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton)
    {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        secondsRemaining = eggTimes[hardness]!
        totalTime=eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector (updateTimer), userInfo: nil, repeats: true)
        print ("The Egg will take \(secondsRemaining) seconds to cook to desire")
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: "alarm_sound" , withExtension: "mp3")!
            player = try! AVAudioPlayer(contentsOf: url)
            player!.play()
        }
    
    @objc func updateTimer()
    {
        if secondsPassed < totalTime
        {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
        }
        else
        {
            timer.invalidate()
            titleLabel.text = "Done!"
            print("Done")
            playSound(soundName: "alarm_sound")
        }
    }
}
