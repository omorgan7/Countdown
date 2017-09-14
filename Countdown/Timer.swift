//
//  TimerModel.swift
//  Countdown
//
//  Created by Owen Morgan on 05/09/2017.
//  Copyright © 2017 Owen Morgan. All rights reserved.
//

import Foundation
import AVFoundation

class Timer{
    
    
    var isPlaying : Bool{
        get{
            return loopPlayer.isPlaying || lastThirtySecondsPlayer.isPlaying
        }
    }
    var spinner : Spinner? = nil
    let countdownSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "countdown", ofType: "wav")!)
    let countdownLoopSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "countdownloop", ofType: "wav")!)
    
    let loopPlayer: AVAudioPlayer
    let lastThirtySecondsPlayer : AVAudioPlayer
    
    init(){
        //I want it to crash if these sounds aren't found, or the app isn't going anywhere
        loopPlayer = try! AVAudioPlayer(contentsOf: countdownLoopSound as URL)
        loopPlayer.numberOfLoops = -1
        lastThirtySecondsPlayer = try! AVAudioPlayer(contentsOf: countdownSound as URL)
    }
    
    func computeLoopOffsetTime(_ duration: Double) -> Double{
        //return (round(duration/7)-(duration/7))*7
        return duration.truncatingRemainder(dividingBy: 7)
    }
    
    func play(for duration: Double){
        if isPlaying == false{
            spinner?.animateSpinner(duration)
            if duration <= 30{
                playLastThirty(for: duration)
            }
            else{
                loopPlayer.stop()
                updateLoop(for: duration)
            }
        }
    }
    
    private func playLastThirty(for duration: Double){
        lastThirtySecondsPlayer.currentTime = 30-duration
        lastThirtySecondsPlayer.play()
    }
    
    private var startTime : DispatchTime = DispatchTime.now()
    
    private var timeNow : DispatchTime{
        get{
            return DispatchTime.now()
        }
    }
    
    var elapsedTime: Double{
        get{
            let timeInNanoSeconds = timeNow.rawValue - startTime.rawValue
            return Double(timeInNanoSeconds)/1000000000
        }

    }
    
    private func updateLoop(for duration: Double){
        startTime = timeNow
        loopPlayer.currentTime = computeLoopOffsetTime(duration)
        print(loopPlayer.currentTime)
        loopPlayer.play()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            while (self?.elapsedTime)! < (duration - 30){
                //this while loop will block the queue until we are good to go.
                //not sure if there's a better way to do it.
                
            }
            self?.loopPlayer.stop()
            self?.lastThirtySecondsPlayer.prepareToPlay()
            self?.playLastThirty(for: 30 - (self?.elapsedTime)! + duration)
        }
    }

}


