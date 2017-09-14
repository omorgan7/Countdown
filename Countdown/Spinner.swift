//
//  SpinnerViewController.swift
//  Countdown
//
//  Created by Owen Morgan on 14/09/2017.
//  Copyright © 2017 Owen Morgan. All rights reserved.
//

import UIKit
import QuartzCore

class Spinner{
    
    var spinnerImage: UIView? = nil
    var isDoneAnimating = true
    var transform = CGAffineTransform(rotationAngle: 0)
    init(_ spinnerImage: UIView){
        self.spinnerImage = spinnerImage
    }
    
    func animateSpinner(_ duration: Double){
        resetSpinner()
        updatingLoop(for: duration)
    }
    
    private func rotate(_ duration: Double, delayedBy delay: Double){
        transform = transform.rotated(by: CGFloat(duration/30) * CGFloat.pi)
        UIView.animate(withDuration: duration, delay: delay, options: .curveLinear,animations: { [weak self] in
            self?.spinnerImage?.transform = (self?.transform)!
            }, completion: { [weak self] in
          self?.isDoneAnimating = $0
        })
    }
    
    func resetSpinner(){
        transform = CGAffineTransform(rotationAngle: 0)
        spinnerImage?.transform = transform
    }
    
    private func updatingLoop(for duration: Double){
        var accumulatedDelay = 0.0
        for _ in 0..<Int(duration)/30{
            rotate(30, delayedBy: accumulatedDelay)
            accumulatedDelay += 30
        }
        if duration.truncatingRemainder(dividingBy: 30) != 0{
            rotate(duration.truncatingRemainder(dividingBy: 30),delayedBy: accumulatedDelay)
        }
    }
}
