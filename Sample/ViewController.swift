//
//  ViewController.swift
//  Sample
//
//  Created by yuki.kuroda on 2018/04/13.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit
import ViewableHandler

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView! {
        didSet {
            targetView.alpha = 0.8
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    @IBAction func startHandle(_ sender: Any) {
        targetView.vh
            .setConfig { config in
                config.timeInterval = 0.5
                config.viewableRatio = 1.0
                config.transparencyRatio = 0.8
            }
            .viewableChanged { state in
            switch state {
            case .viewable:
                self.navigationController?.navigationBar.barTintColor = UIColor.green
            case .unviewable:
                self.navigationController?.navigationBar.barTintColor = UIColor.red
            }
            self.navigationItem.title = state.rawValue
            print("\(self.currentTime): \(state.rawValue)")
        }
    }
    
    @IBAction func stopHandle(_ sender: Any) {
        targetView.vh.inValidate()
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

