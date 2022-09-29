//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var mainUILabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // Title from button coming from.
        let hardness = sender.currentTitle
        
        
//        print(eggTimes[hardness!] ?? "Error")
        
        progressBar.progress = 0.0
        var progressTime:Float? = 0.0
        // variable for the limit time that the progress bar will used.
        let limitBar:Int? = eggTimes[hardness!]
        // the time that will need to pass to have the egg boiled.
        var passedTime:Int? = eggTimes[hardness!]
        
        // This is to repeat the timer and set it up to activate every second.
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            print("\(passedTime!) seconds.")
            // the progress time increases so the calc can be done.
            progressTime! += 1
            // verify progresstime and limit bar != nil. converting to float.
            self.progressBar.progress = Float(progressTime! / Float(limitBar!))
            // passed time will decrease because this tells us if the egg is completely done.
            passedTime! -= 1
            if passedTime == 0 {
                self.mainUILabel.text = "Done!"
                timer.invalidate()
                self.playSound()
                
            }
        }
    }
    
}
