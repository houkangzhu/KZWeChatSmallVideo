//
//  ViewController.swift
//  KZWeChatSmallVideo
//
//  Created by HouKangzhu on 16/7/11.
//  Copyright © 2016年 侯康柱. All rights reserved.
//

import UIKit

class ViewController: UIViewController , KZVideoViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func videoAction(sender: AnyObject) {
        let videoVC = KZVideoViewController()
        videoVC.delegate = self
//        self.presentViewController(videoVC, animated: true, completion: nil)
        videoVC.startAnimation()
    }

    func videoViewController(videoViewController: KZVideoViewController!, didRecordVideo video: KZVideoModel!) {
        
    }
    
    func videoViewControllerDidCancel(videoViewController: KZVideoViewController!) {
        
    }
}

