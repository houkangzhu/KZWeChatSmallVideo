//
//  KZfocusView.swift
//  KZWeChatSmallVideo
//
//  Created by HouKangzhu on 16/7/12.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

import UIKit

public let kzSCREEN_WIDTH:CGFloat = UIScreen.mainScreen().bounds.width
public let kzSCREEN_HEIGHT:CGFloat = UIScreen.mainScreen().bounds.height
public let kzDocumentPath:String = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true)[0]

public let kzThemeBlackColor = UIColor.blackColor()
public let kzThemeTineColor = UIColor.greenColor()
public let kzRecordTime:NSTimeInterval = 10.0

public let viewFrame:CGRect = CGRectMake(0, kzSCREEN_HEIGHT*0.4, kzSCREEN_WIDTH, kzSCREEN_HEIGHT*0.6)

class KZUtil: NSObject {
    
    static func videoPath(fileName:String!) -> String {
        return kzDocumentPath.stringByAppendingString("\\\(fileName)")
    }
    
}

class KZfocusView: UIView {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        CGContextSetAllowsAntialiasing(context, true)
        CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
        CGContextSetLineWidth(context, 1.0)
        
        CGContextMoveToPoint(context, 0.0, 0.0)
        CGContextAddRect(context, self.bounds)
        CGContextDrawPath(context, .Stroke)
    }

}

class KZRecordBtn: UIView {
    
    func setuproundButton() {
        let width = self.frame.width
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: width/2)
        
        let trackLayer = CAShapeLayer()
        trackLayer.frame = self.bounds
        trackLayer.strokeColor = UIColor.greenColor().CGColor
        trackLayer.fillColor = UIColor.clearColor().CGColor
        trackLayer.opacity = 1.0
        trackLayer.lineCap = kCALineCapRound
        trackLayer.lineWidth = 2.0
        trackLayer.path = path.CGPath
        self.layer.addSublayer(trackLayer)
    }
    
    func setupShadowButton() {
        let width = self.frame.width
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: width/2)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.greenColor().CGColor, UIColor.yellowColor().CGColor, UIColor.blueColor()]
        gradientLayer.locations = [NSNumber(float: 0.3), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        gradientLayer.startPoint = CGPointMake(0.0, 1.0)
        gradientLayer.endPoint = CGPointMake(0.0, 0.0)
        
        gradientLayer.shadowPath = path.CGPath
        self.layer.addSublayer(gradientLayer)
    }
    
    func setupView() {
        self.backgroundColor = UIColor.clearColor()
        
        let width = self.frame.width
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: width/2)
        
        let trackLayer = CAShapeLayer()
        trackLayer.frame = self.bounds
        trackLayer.strokeColor = UIColor.greenColor().CGColor
        trackLayer.fillColor = UIColor.clearColor().CGColor
        trackLayer.opacity = 1.0
        trackLayer.lineCap = kCALineCapRound
        trackLayer.lineWidth = 2.0
        trackLayer.path = path.CGPath
        trackLayer.masksToBounds = true
        self.layer.addSublayer(trackLayer)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.greenColor().CGColor, UIColor.yellowColor().CGColor, UIColor.blueColor()]
        gradientLayer.locations = [NSNumber(float: 0.0), NSNumber(float: 0.6), NSNumber(float: 1.0)]
        gradientLayer.startPoint = CGPointMake(0.0, 1.0)
        gradientLayer.endPoint = CGPointMake(0.0, 0.0)
        
        gradientLayer.shadowPath = path.CGPath
        trackLayer.addSublayer(gradientLayer)
    }
    
}

class KZControllerBar: UIView {
    
    let startBtn = UIButton(type: .Custom)
    let longPress = UILongPressGestureRecognizer()
    
    var delegate:KZControllerBarDelegate?
    
    let progressLine = UIView()
    var touchIsInside:Bool = true
    
    var timer:NSTimer! = nil
    var surplusTime:NSTimeInterval! = nil
    
    func setupSubViews() {
        self.layoutIfNeeded()
        
        let selfHeight = self.bounds.height
        let selfWidth = self.bounds.width
        
        let startBtnWidth = selfHeight - 40
        startBtn.frame = CGRectMake((selfWidth - startBtnWidth)/2, 20, startBtnWidth, startBtnWidth)
        startBtn.backgroundColor = UIColor.yellowColor()
        startBtn.addTarget(self, action: #selector(KZControllerBar.videoStartAction(_:)), forControlEvents: .TouchDown)
        startBtn.addTarget(self, action: #selector(KZControllerBar.videoCancelAction), forControlEvents: .TouchUpOutside)
        startBtn.layer.cornerRadius = startBtnWidth/2
        startBtn.layer.masksToBounds = true
        self.addSubview(self.startBtn)
        
        self.longPress.addTarget(self, action: #selector(longpressAction(_:)))
        self.addGestureRecognizer(self.longPress)
        
        self.progressLine.frame = CGRectMake(0, 0, selfWidth, 4)
        self.progressLine.backgroundColor = kzThemeTineColor
        self.progressLine.hidden = true
        self.addSubview(self.progressLine)
        
        
//        let view = KZRecordBtn(frame:CGRectMake(20, 10, 80, 80))
//        view.setuproundButton()
//        self.addSubview(view)
    }
    
    private func startTimer() {
        self.progressLine.frame = CGRectMake(0, 0, self.bounds.width, 4)
        self.progressLine.hidden = false
        self.surplusTime = kzRecordTime
        if self.timer == nil {
            self.timer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(KZControllerBar.recordTimerAction), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSDefaultRunLoopMode)
        }
        self.timer.fire()
    }
    
    private func endTimer() {
        self.progressLine.hidden = true
        self.timer.invalidate()
        self.timer = nil
    }
    
    // MARK: - Actions
    func videoStartAction(sender:UIButton) {
        self.startTimer()
        self.delegate?.videoDidStart!(self)
    }
    func videoEndAction() {
        self.delegate?.videoDidEnd!(self)
    }
    func videoCancelAction() {
        self.delegate?.videoDidCancel!(self)
    }
    
    func longpressAction(sender:UILongPressGestureRecognizer) {
        let point = sender.locationInView(self)
        switch sender.state {
        case .Began:
            print("began")
            break
        case .Changed:
            self.touchIsInside = point.y >= 0
            if !touchIsInside {
                self.delegate?.videoWillCancel!(self)
            }
            print("changed")
            break
        case .Ended:
            self.endTimer()
            if !touchIsInside {
                self.videoCancelAction()
            }
            else {
                self.videoEndAction()
            }
            print("ended")
            break
        case .Cancelled:
            
            print("cancelled")
            break
        default:
            print("other")
            break
        }
    }
    
    func recordTimerAction() {
        print("timer repeat")
        let reduceLen = self.bounds.width/CGFloat(kzRecordTime)
        let oldLineLen = self.progressLine.frame.width
        var oldFrame = self.progressLine.frame
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveLinear, animations: {
            oldFrame.size.width = oldLineLen - reduceLen
            self.progressLine.frame = oldFrame
            self.progressLine.center = CGPointMake(self.bounds.width/2, 2)
        }) { (finished) in
            self.surplusTime = self.surplusTime - 1
            if self.surplusTime <= 0.0 {
                self.endTimer()
                self.videoEndAction()
            }
        }
    }
}

@objc protocol KZControllerBarDelegate {
    
    optional func videoDidStart(controllerBar:KZControllerBar!)
    
    optional func videoDidEnd(controllerBar:KZControllerBar!)
    
    optional func videoDidCancel(controllerBar:KZControllerBar!)
    
    optional func videoWillCancel(controllerBar:KZControllerBar!)
    
    optional func videoDidRecordSEC(controllerBar:KZControllerBar!)
}