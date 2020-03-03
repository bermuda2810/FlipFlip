//
//  CircleView.swift
//  KlassTimer
//
//  Created by Bui Quoc Viet on 2/15/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation
import UIKit

class CircleView : UIView{
    private var startAngle = -CGFloat.pi/2.0
    private let lineWidth : CGFloat = 12.0
    private let _360radian = 2*CGFloat.pi
    private var endAngle = -CGFloat.pi/2.0 + 2*CGFloat.pi
    private var totalSeconds = 1*60
    private var remainingSeconds = 1*60
    private var gradient : CAGradientLayer? = nil
    
    override func draw(_ rect: CGRect) {
        let centerPoint = CGPoint.init(x: rect.width/2.0, y: rect.height/2.0)
        let radius = (rect.width - lineWidth)/2.0
        drawCircle(centerPoint, CGFloat(radius))
    }
    
    func drawCircle(_ centerPoint : CGPoint,_ radius : CGFloat) {
        gradient?.removeFromSuperlayer()
        let path: UIBezierPath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = CGFloat(lineWidth)
        
        gradient = CAGradientLayer()
        gradient?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradient?.colors = [cgColor(red: 253, green: 109, blue: 118),
                           cgColor(red: 253, green: 109, blue: 118)]
        gradient?.startPoint = CGPoint(x: 0, y: 0)
        gradient?.endPoint = CGPoint(x: 1, y: 0)
        gradient?.mask = shapeLayer
        
        self.layer.addSublayer(gradient!)
    }
    
    func cgColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGColor {
      return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
    }
    
    func setData(seconds : Int) {
        self.totalSeconds = seconds
        self.remainingSeconds = seconds
    }
    
    func countDown() {
        self.remainingSeconds -= 1
        self.endAngle = startAngle + (CGFloat.init(remainingSeconds)/CGFloat.init(totalSeconds))*_360radian
        self.setNeedsDisplay()
    }
}
