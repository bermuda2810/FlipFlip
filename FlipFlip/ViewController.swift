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
    
    var firstView: UIView!
    var secondView: UIView!
    let motionManager = CMMotionManager()
    @IBOutlet weak var btnStart: UIButton!
    var audioPlayer : AVAudioPlayer?
    
    @IBOutlet weak var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                        print("Acceleration Z : ", data?.acceleration.z as Any)
        }
        Timer.scheduledTimer(timeInterval: 17.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        btnStart.addTarget(self, action: #selector(onStartPressed), for: UIControl.Event.touchUpInside)
        
        button2.addTarget(self, action: #selector(onStartPressed), for: UIControl.Event.touchUpInside)
    }
    
    @objc func countDown(caller : Any?) {
//        print("count down")
    }
    
    @objc func onStartPressed() {
        print("onStartPressed")
        guard let fileURL = Bundle.main.path(forResource: "alarm", ofType: "wav") else { return }
        print("Continue processing")
        var user = User()
        var user1 = user
        user.name = "Hung"
        user1.name = "Viet"
        print(" \(user.name) va \(user1.name)")
        let url = URL(fileURLWithPath: fileURL)
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.numberOfLoops = 1
        audioPlayer?.play()
    }
}

