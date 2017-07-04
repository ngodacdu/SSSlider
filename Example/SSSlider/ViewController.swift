//
//  ViewController.swift
//  SSSlider
//
//  Created by ngodacdu on 06/30/2017.
//  Copyright (c) 2017 ngodacdu. All rights reserved.
//

import UIKit
import SSSlider

class ViewController: UIViewController {

    @IBOutlet weak var horizontalSlider: SSSlider!
    @IBOutlet weak var downVerticalSlider: SSSlider!
    @IBOutlet weak var upVerticalSlider: SSSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // for horizontal
        horizontalSlider.didChangeValueBegan = { (slider, value) in
            print("HorizontalSlider change value began \(value)")
        }
        horizontalSlider.didChangeValue = { (slider, value) in
            print("HorizontalSlider change value \(value)")
        }
        horizontalSlider.didChangeValueEnded = { (slider, value) in
            print("HorizontalSlider change value end \(value)")
        }
        
        // for downVertial
        downVerticalSlider.didChangeValueBegan = { (slider, value) in
            print("DownVerticalSlider change value began \(value)")
        }
        downVerticalSlider.didChangeValue = { (slider, value) in
            print("DownVerticalSlider change value \(value)")
        }
        downVerticalSlider.didChangeValueEnded = { (slider, value) in
            print("DownVerticalSlider change value end \(value)")
        }
        
        // for upVertical
        upVerticalSlider.didChangeValueBegan = { (slider, value) in
            print("UpVerticalSlider change value began \(value)")
        }
        upVerticalSlider.didChangeValue = { (slider, value) in
            print("UpVerticalSlider change value \(value)")
        }
        upVerticalSlider.didChangeValueEnded = { (slider, value) in
            print("UpVerticalSlider change value end \(value)")
        }
    }
    
    @IBAction func didTouchChangeValue(_ sender: Any) {
        let value: CGFloat = CGFloat(Int(arc4random_uniform(101))) / 100.0
        horizontalSlider.setValue(percent: value, animated: true)
        downVerticalSlider.setValue(percent: value, animated: false)
        upVerticalSlider.setValue(percent: value, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

