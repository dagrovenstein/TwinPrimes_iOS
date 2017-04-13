
//  ViewController.swift
//  Project6
//
//  Created by Danny G on 10/17/16.
//  Copyright © 2016 Daniel Grovenstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tf: UITextField!
    @IBOutlet var tv: UITextView!
    @IBOutlet var pb: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tv.layoutManager.allowsNonContiguousLayout = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func runTwinPrimes(sender: AnyObject) {
        self.tv.text = ""
        let n = Int(tf.text!)!
        let q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        var totalCounter = 0
        var twinPrimeStr:String = ""
        var p :Float!
        
        let mainq = dispatch_get_main_queue()
        dispatch_async(q) {
            var k = 0
            var lastPrime = 1
            
            var i = 1
            while (i < n) {
                k=2
                while (k < i) {
                    if (i % k == 0) {
                        break;
                    }
                    k+=1
                }
                if (i == k) {
                    if ((i - lastPrime) == 2) {
                        twinPrimeStr += "[" + "\(i-2)" + "," + "\(i)" + "]" + " "
                        totalCounter+=1
            
                        dispatch_async(mainq) {
                            self.tv.text = twinPrimeStr
                            p = Float(i)/Float(n)
                            self.pb.setProgress(p, animated: false)
                            if (n > 1000) {
                            self.tv.contentOffset = CGPointMake(0, self.tv.contentSize.height - self.tv.frame.size.height)
                            }
                        }
                    }
                    lastPrime = i
                }
                i+=1
        }
            twinPrimeStr += "total: " + String(totalCounter)
            
            dispatch_async(mainq){
                self.pb.setProgress(1, animated: false)
                self.tv.text = "twins: " + twinPrimeStr
            
            }
        }
    }
}

