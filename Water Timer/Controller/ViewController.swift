//
//  ViewController.swift
//  Water Timer
//
//  Created by Nick Khachatryan on 20.10.2020.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    //  MARK: - OUTLETS
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    //  MARK: - CUSTOM PROPERTIES
    let tenMinutes = 10
    let fifteenMinutes = 15
    let twentyMinutes = 20
    let dict : [String : Int] = [
        "10 min" : 600 ,
        "15 min" : 900 ,
        "20 min" : 1200
    ]
    var timer = Timer()
    let systemSound : SystemSoundID = 1016
    
    
    //  MARK: - VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
        print("viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    
    //  MARK: - ACTIONS
    @IBAction func pressedGlasses(_ sender: UIButton) {
        progressBar.progressTintColor = .white
        progressBar.trackTintColor = .systemGray4
        guard let minutes = sender.currentTitle else { return }
        guard var count = dict[minutes] else { return }
        let permanentSeconds = count
        timer.invalidate()
        progressBar.progress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (time) in
            if count > 0 {
                count -= 1
                let countForward = permanentSeconds - count
                print(countForward)
                self.progressBar.progress = Float(countForward) / Float(permanentSeconds)
                self.infoLabel.text = "\(count) seconds"
            } else {
                self.infoLabel.text = "Done!\nTime is Over".uppercased()
                AudioServicesPlaySystemSound(self.systemSound)
                self.timer.invalidate()
            }
        }
    }
}

