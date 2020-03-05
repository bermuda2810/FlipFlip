//
//  ViewController.swift
//  FlipFlip
//
//  Created by Bui Quoc Viet on 2/3/20.
//  Copyright © 2020 Class iOS. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var circleTimerView: CircleView!
    var firstView: UIView!
    var secondView: UIView!
    let motionManager = CMMotionManager()
    @IBOutlet weak var btnStart: UIButton!
    var audioPlayer : AVAudioPlayer?
    var prepareTime : Int = 10 // 5seconds
    var learningTime : Int = 90*60 // 90minutes
    
    var currentTime : Int = 0
    var stateTimer : Int = 0 // Start
    var currentTimer : MyTimer? = nil
    
    let PREPARING : Int = 0
    let LEARNING : Int = 1
    let FINISHED : Int = 2
    
    var facing : Int = 0 // Default
    
    @IBOutlet weak var lblTimer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
//                        print("Acceleration Z : ", data?.acceleration.z as Any)
        }
        btnStart.addTarget(self, action: #selector(onStartPressed), for: UIControl.Event.touchUpInside)
    }
    
    
    @objc func countDown(caller : Any?) {
        currentTime -= 1
        let minute = currentTime / 60
        let second = currentTime % 60
        let strTime = "\(minute):\(second)"
        lblTimer.text = strTime
        if currentTime == 0 {
            currentTimer?.invalidate()
//            onTimerFinished()
        }
    }
    
    private func onTimerFinished() {
        if stateTimer == PREPARING {
            stateTimer = LEARNING
        }else if stateTimer == LEARNING{
            stateTimer = FINISHED
        }
        handleState()
    }
 
    @objc func onStartPressed() {
        handleState()
    }
    
    private func handleState() {
        if (stateTimer == PREPARING) {
            currentTime = prepareTime
            prepareToCountdown()
        }else if(stateTimer == LEARNING){
            currentTime = learningTime
            prepareToCountdown()
        }else {
            print("Finsihed")
        }
    }
    
    private func prepareToCountdown() {
        circleTimerView.startAnimationCountdown(seconds: currentTime)
//        currentTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        currentTimer = MyTimer.scheduledTimer(interval: 1.0, target: self, selector: #selector(countDown), repeate: true)
    }
    
    private func playSound() {
        guard let fileURL = Bundle.main.path(forResource: "alarm", ofType: "wav") else { return }
        let url = URL(fileURLWithPath: fileURL)
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.numberOfLoops = 1
        audioPlayer?.play()
    }
}

