//
//  ViewController.swift
//  Sample
//
//  Created by yuki.kuroda on 2018/04/13.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit
import Visibility

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView! {
        didSet {
//            targetView.alpha = 0.4
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func startHandle(_ sender: Any) {
        targetView.visibility
//            .setConfig { config in
//                config.timeInterval = 1.0
//                config.intersectionRatio = 0.8
//                config.transparencyRatio = 0.5
//            }
            .changed { state in
                switch state {
                case .visible:
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                case .invisible:
                    self.navigationController?.navigationBar.barTintColor = UIColor.red
            }
            self.navigationItem.title = state.rawValue
            print("\(self.currentTime): \(state.rawValue)")
        }
    }
    
    @IBAction func stopHandle(_ sender: Any) {
        targetView.visibility.invalidate()
    }
    
    @IBAction func removeView(_ sender: Any) {
        targetView.removeFromSuperview()
    }
    
    var currentTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

