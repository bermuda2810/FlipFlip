//
//  ViewController.swift
//  FlipFlip
//
//  Created by Bui Quoc Viet on 2/3/20.
//  Copyright © 2020 Class iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var firstView: UIView!
    var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView = UIView(frame: CGRect(x: 32, y: 32, width: 128, height: 128))
        secondView = UIView(frame: CGRect(x: 32, y: 32, width: 128, height: 128))

        firstView.backgroundColor = UIColor.red
        secondView.backgroundColor = UIColor.blue

        secondView.isHidden = true

        view.addSubview(firstView)
        view.addSubview(secondView)


        perform(#selector(flip), with: nil, afterDelay: 2)
    }

    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft]

        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
            self.firstView.isHidden = true
        })

        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
            self.secondView.isHidden = false
        })
    }
}

