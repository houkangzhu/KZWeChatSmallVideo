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
        super.drawRect(rect)
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

class KZCloseBtn: UIButton {
    
    func setupView() {
//        self.layer.backgroundColor = UIColor.whiteColor().CGColor
//        let centX = self.center.x
//        let centY = self.center.y
//        let drawWidth:CGFloat = 30
//        let drawHeight:CGFloat = 20
//        let path = CGPathCreateMutable()
//        CGPathMoveToPoint(path, nil, (centX - drawWidth/2), (centY + drawHeight/2))
//        CGPathAddLineToPoint(path, nil, centX, centY - drawHeight/2)
//        CGPathAddLineToPoint(path, nil, centX + drawWidth/2, centY + drawHeight/2)
//        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.frame = self.bounds
//        shapeLayer.strokeColor = kzThemeTineColor.CGColor
//        shapeLayer.fillColor = UIColor.blueColor().CGColor
//        shapeLayer.opacity = 1.0
//        shapeLayer.lineCap = kCALineCapRound
//        shapeLayer.lineWidth = 4.0
//        shapeLayer.path = path
//        self.layer.addSublayer(shapeLayer)
    }
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
        let context = UIGraphicsGetCurrentContext()
        CGContextSetAllowsAntialiasing(context, true)
        CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
        CGContextSetLineWidth(context, 4.0)
        CGContextSetLineCap(context, .Round);
        
        let centX = self.center.x
        let centY = self.center.y
        
        let drawWidth:CGFloat = 30
        let drawHeight:CGFloat = 20
        
//        let path = CGPathCreateMutable()
//        
//        CGPathMoveToPoint(path, nil, (centX - drawWidth/2), (centY + drawHeight/2))
//        CGPathAddLineToPoint(path, nil, centX, centY - drawHeight/2)
//        CGPathAddLineToPoint(path, nil, centX + drawWidth/2, centY + drawHeight/2)
        
        CGContextBeginPath(context);
        
        CGContextMoveToPoint(context, (centX - drawWidth/2), (centY + drawHeight/2))
        CGContextAddLineToPoint(context, centX, centY - drawHeight/2)
        CGContextAddLineToPoint(context, centX + drawWidth/2, centY + drawHeight/2)
        
//        CGContextDrawPath(context, .Stroke)
        CGContextStrokePath(context)
    }
}

class KZRecordBtn: UIView {
    
    var tapGesture: UITapGestureRecognizer! = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setuproundButton()
        self.layer.cornerRadius = self.bounds.width/2
        self.layer.masksToBounds = true
        self.userInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addtarget(target:AnyObject!, action:Selector) {
        self.tapGesture = UITapGestureRecognizer(target: target, action:action)
        self.addGestureRecognizer(self.tapGesture)
    }
    
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

class KZControllerBar: UIView , UIGestureRecognizerDelegate{
    
    var startBtn:KZRecordBtn? = nil
    let longPress = UILongPressGestureRecognizer()
    
    var delegate:KZControllerBarDelegate?
    
    let progressLine = UIView()
    var touchIsInside:Bool = true
    var recordDidStart:Bool = false
    
    var timer:NSTimer! = nil
    var surplusTime:NSTimeInterval! = nil
    
    
    var videoListBtn:UIButton! = nil
    var closeVideoBtn:KZCloseBtn! = nil
    
    deinit {
        print("ctrlView deinit")
    }
    
    func setupSubViews() {
        self.layoutIfNeeded()
        
        let selfHeight = self.bounds.height
        let selfWidth = self.bounds.width
        
        let edge:CGFloat! = 20.0
        
        
        let startBtnWidth = selfHeight - (edge * 2)
        
        self.startBtn = KZRecordBtn(frame: CGRectMake((selfWidth - startBtnWidth)/2, edge, startBtnWidth, startBtnWidth))
        self.addSubview(self.startBtn!)
        
        self.longPress.addTarget(self, action: #selector(KZControllerBar.longpressAction(_:)))
        self.longPress.minimumPressDuration = 0.01
        self.longPress.delegate = self
        self.addGestureRecognizer(self.longPress)
        
        self.progressLine.frame = CGRectMake(0, 0, selfWidth, 4)
        self.progressLine.backgroundColor = kzThemeTineColor
        self.progressLine.hidden = true
        self.addSubview(self.progressLine)
        
        self.surplusTime = kzRecordTime
    
        self.videoListBtn = UIButton(type:.Custom)
        self.videoListBtn.frame = CGRectMake(edge, edge+startBtnWidth/6, startBtnWidth/4*3, startBtnWidth/3*2)
        self.videoListBtn.layer.cornerRadius = 8
        self.videoListBtn.layer.masksToBounds = true
        self.videoListBtn.addTarget(self, action: #selector(videoListAction), forControlEvents: .TouchUpInside)
        self.videoListBtn.backgroundColor = kzThemeTineColor
        self.addSubview(self.videoListBtn)
        
        
        self.closeVideoBtn = KZCloseBtn(type: .Custom)
        self.closeVideoBtn.frame = CGRectMake(self.bounds.width - self.videoListBtn.bounds.width - edge, self.videoListBtn.frame.minY, self.videoListBtn.frame.width, self.videoListBtn.frame.height)
        self.closeVideoBtn.setupView()
        self.closeVideoBtn.addTarget(self, action: #selector(videoCloseAction), forControlEvents: .TouchUpInside)
        self.addSubview(self.closeVideoBtn)
    }
    
    private func startRecordSet() {
        self.startBtn?.alpha = 1.0
        self.progressLine.frame = CGRectMake(0, 0, self.bounds.width, 4)
        self.progressLine.hidden = false
        self.surplusTime = kzRecordTime
        if self.timer == nil {
            self.timer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(KZControllerBar.recordTimerAction), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(self.timer, forMode: NSDefaultRunLoopMode)
        }
        self.timer.fire()
        
        UIView.animateWithDuration(0.4, animations: {
            self.startBtn?.alpha = 0.0
            self.startBtn?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
        }) { (finished) in
            if finished {
                self.startBtn?.transform = CGAffineTransformIdentity
            }
        }
    }
    
    private func endTimer() {
        self.progressLine.hidden = true
        self.timer?.invalidate()
        self.timer = nil
        
        self.startBtn?.alpha = 1
    }
    
    // MARK: - UIGestureRecognizerDelegate --
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.longPress {
            if self.surplusTime <= 0 {
                return false
            }
            
            let point = gestureRecognizer.locationInView(self)
            let startBtnCenter = self.startBtn!.center;
            let dx = point.x - startBtnCenter.x
            let dy = point.y - startBtnCenter.y
            if (pow(dx, 2) + pow(dy, 2) < pow(startBtn!.bounds.width/2, 2)) {
                return true
            }
            return false
        }
        return true
    }
    
    // MARK: - Actions
    func videoStartAction() {
        self.startRecordSet()
        self.delegate?.videoDidStart!(self)
    }
    func videoEndAction() {
        self.delegate?.videoDidEnd!(self)
    }
    func videoCancelAction() {
        self.delegate?.videoDidCancel!(self)
    }
    
    func longpressAction(gestureRecognizer:UILongPressGestureRecognizer) {
        let point = gestureRecognizer.locationInView(self)
        switch gestureRecognizer.state {
        case .Began:
            self.videoStartAction()
//            print("began")
            break
        case .Changed:
            self.touchIsInside = point.y >= 0
            if !touchIsInside {
                self.delegate?.videoWillCancel!(self)
            }
//            print("changed")
            break
        case .Ended:
            self.endTimer()
            if !touchIsInside {
                self.videoCancelAction()
            }
            else {
                self.videoEndAction()
            }
//            print("ended")
            break
        case .Cancelled:
            
//            print("cancelled")
            break
        default:
//            print("other")
            break
        }
    }
    
    func recordTimerAction() {
//        print("timer repeat")
        let reduceLen = self.bounds.width/CGFloat(kzRecordTime)
        let oldLineLen = self.progressLine.frame.width
        var oldFrame = self.progressLine.frame
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveLinear, animations: {
            
            oldFrame.size.width = oldLineLen - reduceLen
            self.progressLine.frame = oldFrame
            self.progressLine.center = CGPointMake(self.bounds.width/2, 2)
        
        }) { (finished) in
            
            self.surplusTime = self.surplusTime - 1
            self.delegate?.videoDidRecordSEC!(self)
            if self.surplusTime <= 0.0 {
                self.endTimer()
                self.videoEndAction()
            }
        }
    }
    
    func videoListAction(sender:UIButton) {
        
    }
    
    func videoCloseAction(sender:UIButton) {
        
    }
}

@objc protocol KZControllerBarDelegate {
    
    optional func videoDidStart(controllerBar:KZControllerBar!)
    
    optional func videoDidEnd(controllerBar:KZControllerBar!)
    
    optional func videoDidCancel(controllerBar:KZControllerBar!)
    
    optional func videoWillCancel(controllerBar:KZControllerBar!)
    
    optional func videoDidRecordSEC(controllerBar:KZControllerBar!)
}