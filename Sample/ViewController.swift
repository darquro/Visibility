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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
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
                    self.navigationController?.navigationBar.barTintColor = UIColor(red:0.26, green:0.63, blue:0.28, alpha:1.0)
                case .invisible:
                    self.navigationController?.navigationBar.barTintColor = UIColor(red:0.96, green:0.26, blue:0.21, alpha:1.0)
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

