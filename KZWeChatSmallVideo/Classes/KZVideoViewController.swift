//
//  KZVideoViewController.swift
//  KZWeChatSmallVideo
//
//  Created by HouKangzhu on 16/7/11.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

import UIKit
import AVFoundation


class KZVideoViewController: UIViewController, UIViewControllerTransitioningDelegate, KZControllerBarDelegate {

    let actionView:UIView! = UIView(frame: viewFrame)
    
    let topSlideView:UIView! = UIView()
//    let <#name#> = <#value#>
    
    
    let videoView:UIView! = UIView()
    let focusView:KZfocusView! = KZfocusView(frame: CGRectMake(0, 0, 60, 60))
    
    
    let ctrlBar:KZControllerBar! = KZControllerBar()
    
    
    var videoPreLayer:AVCaptureVideoPreviewLayer! = nil
    var videoDevice:AVCaptureDevice! = nil
    var moveOut:AVCaptureMovieFileOutput? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor ( red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0 )
        self.setupSubViews()
        do {
            try self.setupVideo()
        }
        catch let error as NSError {
            print("error: \(error)")
        }
        
        // 
        let cancelBtn = UIButton(type: .Custom)
        cancelBtn.titleLabel?.text = "cancel"
        cancelBtn.frame = CGRectMake(0, 0, 60, 60)
        cancelBtn.addTarget(self, action: #selector(KZVideoViewController.cancelDismiss), forControlEvents: .TouchUpInside)
        self.view.addSubview(cancelBtn)
    }
    
    // MARK: - satup Views
    private func setupSubViews() {
        self.actionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.actionView)
        
        let themeColor = kzThemeBlackColor
        
        let topHeight:CGFloat = 20.0
        let buttomHeight:CGFloat = 140.0
        
        let allHeight = actionView.frame.height
        let allWidth = actionView.frame.width
        
        
        self.topSlideView.frame = CGRectMake(0, 0, allWidth, topHeight)
        self.topSlideView.backgroundColor = themeColor
        self.actionView.addSubview(self.topSlideView)
        
        
        self.ctrlBar.frame = CGRectMake(0, allHeight - buttomHeight, allWidth, buttomHeight)
        self.ctrlBar.setupSubViews()
        self.ctrlBar.backgroundColor = themeColor
        self.ctrlBar.delegate = self
        self.actionView.addSubview(self.ctrlBar)
        
        
        self.videoView.frame = CGRectMake(0, CGRectGetMaxY(self.topSlideView.frame), allWidth, allHeight - topHeight - buttomHeight)
        self.actionView.addSubview(self.videoView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(KZVideoViewController.focusAction(_:)))
        self.videoView.addGestureRecognizer(tapGesture)
        
        self.focusView.backgroundColor = UIColor.clearColor()
    }
    // MARK: - setup Video
    private func setupVideo() throws {
        let devicesVideo = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        let devicesAudio = AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio)
        
        let videoInput = try AVCaptureDeviceInput(device: devicesVideo[0] as! AVCaptureDevice)
        let audioInput = try AVCaptureDeviceInput(device: devicesAudio[0] as! AVCaptureDevice)
        
        self.videoDevice = devicesVideo[0] as! AVCaptureDevice
        
        let moveOut = AVCaptureMovieFileOutput()
        self.moveOut = moveOut
        
        let session = AVCaptureSession()
        if session.canSetSessionPreset(AVCaptureSessionPreset640x480) {
            session.canSetSessionPreset(AVCaptureSessionPreset640x480)
        }
        if session.canAddInput(videoInput) {
            session.addInput(videoInput)
        }
        if session.canAddInput(audioInput) {
            session.addInput(audioInput)
        }
        if session.canAddOutput(moveOut) {
            session.addOutput(moveOut)
        }
        
        self.videoPreLayer = AVCaptureVideoPreviewLayer(session: session)
        self.videoPreLayer.frame = self.videoView.bounds
        self.videoPreLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoView.layer.addSublayer(self.videoPreLayer)
        
        session.startRunning()
    }
    
    
    // MARK: - Actions
    // 聚焦
    func focusAction(sender:UITapGestureRecognizer) {
        let point = sender.locationInView(self.videoView)
        self.focusView.center = point
        self.videoView.addSubview(self.focusView)
        self.videoView.bringSubviewToFront(self.focusView)
        
        if self.videoDevice.accessibilityElementIsFocused() && self.videoDevice.isFocusModeSupported(.AutoFocus) {
            do {
                try self.videoDevice.lockForConfiguration()
                self.videoDevice.focusMode = .AutoFocus
                self.videoDevice.focusPointOfInterest = point
                self.videoDevice.unlockForConfiguration()
            }
            catch let error as NSError {
                print("error: \(error)")
            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0*Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.focusView.removeFromSuperview()
        }
    }
    
    func cancelDismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - controllerBarDelegate
    
    func videoDidStart(controllerBar: KZControllerBar!) {
        
    }
    
    func videoDidEnd(controllerBar: KZControllerBar!) {
        
    }
    
    func videoDidCancel(controllerBar: KZControllerBar!) {
        
    }
    
    func videoWillCancel(controllerBar: KZControllerBar!) {
        
    }
    
    func videoDidRecordSEC(controllerBar: KZControllerBar!) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
