//
//  SettingViewController.swift
//
//  Created by Alan on 2021/12/16.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tip1: UITextField!
    @IBOutlet weak var tip1minus: UIButton!
    @IBOutlet weak var tip1plus: UIButton!
    
    @IBOutlet weak var tip2: UITextField!
    @IBOutlet weak var tip2minus: UIButton!
    @IBOutlet weak var tip2plus: UIButton!
    
    @IBOutlet weak var tip3: UITextField!
    @IBOutlet weak var tip3minus: UIButton!
    @IBOutlet weak var tip3plus: UIButton!
    
    @IBOutlet weak var saveNotification: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        saveNotification.text = nil

        //get the tip percentage1,2,3 from main screen and update them into boxes
        tip1.text = "\(UserDefaults.standard.integer(forKey: "tipPercentage1"))"
        tip2.text = "\(UserDefaults.standard.integer(forKey: "tipPercentage2"))"
        tip3.text = "\(UserDefaults.standard.integer(forKey: "tipPercentage3"))"
    }

    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func tip1Edited(_ sender: Any) {
        UserDefaults.standard.set(Int(tip1.text!), forKey: "tipPercentage1")
        saveNotification.text = String("Tip Percentage 1 Saved")
        saveNotification.animation(0.5)
        
    }
    
    @IBAction func tip1plus(_ sender: Any) {
        let curr = Int(tip1.text!) ?? 0
        let added = Int(curr + 1)
        tip1.text = String("\(added)")
        UserDefaults.standard.set(Int(tip1.text!), forKey: "tipPercentage1")
        saveNotification.text = String("Tip Percentage 1 Saved")
        saveNotification.animation(0.5)
    }

    
    @IBAction func tip1minus(_ sender: Any) {
        let curr = Int(tip1.text!) ?? 0
        let less = Int(curr - 1)
        tip1.text = String("\(less)")
        UserDefaults.standard.set(Int(tip1.text!), forKey: "tipPercentage1")
        saveNotification.text = String("Tip Percentage 1 Saved")
        saveNotification.animation(0.5)
    }
//      update the change to the main screen

    
    @IBAction func tip2Edited(_ sender: Any) {
        UserDefaults.standard.set(Int(tip2.text!), forKey: "tipPercentage2")
        saveNotification.text = String("Tip Percentage 2 Saved")
        saveNotification.animation(0.5)
    }
    
    @IBAction func tip2plus(_ sender: Any) {
        let curr = Int(tip2.text!) ?? 0
        let added = Int(curr + 1)
        tip2.text = String("\(added)")
        UserDefaults.standard.set(Int(tip2.text!), forKey: "tipPercentage2")
        saveNotification.text = String("Tip Percentage 2 Saved")
        saveNotification.animation(0.5)
    }
//      update the change to the main screen
    
    
    @IBAction func tip2minus(_ sender: Any) {
        let curr = Int(tip2.text!) ?? 0
        let less = Int(curr - 1)
        tip2.text = String("\(less)")
        UserDefaults.standard.set(Int(tip2.text!), forKey: "tipPercentage2")
        saveNotification.text = String("Tip Percentage 2 Saved")
        saveNotification.animation(0.5)
    }
//      update the change to the main screen
    
    @IBAction func tip3Edited(_ sender: Any) {
        UserDefaults.standard.set(Int(tip3.text!), forKey: "tipPercentage3")
        saveNotification.text = String("Tip Percentage 3 Saved")
        saveNotification.animation(0.5)
    }
    
    
    @IBAction func tip3plus(_ sender: Any) {
        let curr = Int(tip3.text!) ?? 0
        let added = Int(curr+1)
        tip3.text = String("\(added)")
        UserDefaults.standard.set(Int(tip3.text!), forKey: "tipPercentage3")
        saveNotification.text = String("Tip Percentage 3 Saved")
        saveNotification.animation(0.5)
    }
    
    
    @IBAction func tip3minus(_ sender: Any) {
        let curr = Int(tip3.text!) ?? 0
        let less = Int(curr - 1)
        tip3.text = String("\(less)")
        UserDefaults.standard.set(Int(tip3.text!), forKey: "tipPercentage3")
        saveNotification.text = String("Tip Percentage 3 Saved")
        saveNotification.animation(0.5)
    }




}
    

// Adding animation for "Tip Percentages Saved": I received help from https://stackoverflow.com/questions/3073520/animate-text-change-in-uilabel
extension UIView {
    func animation(_ duration:TimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        animation.type = CATransitionType.moveIn
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

