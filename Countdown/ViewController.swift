//
//  ViewController.swift
//  Countdown
//
//  Created by Owen Morgan on 05/09/2017.
//  Copyright © 2017 Owen Morgan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var spinnerView: UIView!
    
    var audioPlayer: AVAudioPlayer?
    
    var timer = Timer()
    
    var timeToCountdown : Double?{
        get{
            return Double(secondsEnteredInField.text!)
        }
    }
    
    var countdownSeconds : Double?{
        get{
            if let seconds = secondsEnteredInField.text{
                return Double(seconds)
            }
            else{
                return nil
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.spinner = Spinner(spinnerView!)//outlets will have been hooked up by here, this unwrapping should be a-ok
        //if countdown sound is fucked I want to know about it
    }
    
    @IBOutlet weak var secondsEnteredInField: UITextField!
    
    @IBAction func startCountdown(_ sender: UIButton) {
        if let seconds = countdownSeconds{
            timer.play(for: seconds)
        }
    }
    
}

