//
//  ViewController.swift
//
//  Created by Alan on 2021/12/5.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var billAmountTextfield: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var resetButtom: UIButton!
    @IBOutlet weak var friendNumSlider: UISlider!
    @IBOutlet weak var numOfFriends: UILabel!
    @IBOutlet weak var billPerFriend: UILabel!
    @IBOutlet weak var img: UILabel!
    
    
    override func viewDidLoad() {  //load only once--when the app launches
        super.viewDidLoad()
        self.title = "Tip Calculator"
        //if new-user: set the default tipPercentages
        if UserDefaults.standard.integer(forKey: "tipPercentage1")==EMPTY && UserDefaults.standard.integer(forKey: "tipPercentage2")==EMPTY && UserDefaults.standard.integer(forKey: "tipPercentage3")==EMPTY {
            UserDefaults.standard.set(5, forKey: "tipPercentage1")
            UserDefaults.standard.set(10, forKey: "tipPercentage2")
            UserDefaults.standard.set(15, forKey: "tipPercentage3")
        }

        // retrieve the Bill and Tip and the calculation if <10min
        let noRecord = UserDefaults.standard.object(forKey: "lastCalculationTime") == nil
        if !noRecord{
        let lastQuit : Date = UserDefaults.standard.object(forKey: "lastCalculationTime") as! Date
        let clearTime = lastQuit + 10 * 60
        if Date.init() < clearTime {
            let rememberedBill = UserDefaults.standard.string(forKey: "billAmount")
            billAmountTextfield.text = rememberedBill
            let rememberedTipChoice = UserDefaults.standard.integer(forKey: "tipChoice")
            tipControl.selectedSegmentIndex = rememberedTipChoice
            let rememberedHeadCount = UserDefaults.standard.integer(forKey: "headCount")
            friendNumSlider.value = Float(rememberedHeadCount)
            calculateTip(self)}
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.billAmountTextfield.becomeFirstResponder()
        tipControl.setTitle("\(UserDefaults.standard.integer(forKey: "tipPercentage1"))%", forSegmentAt: 0)
        tipControl.setTitle("\(UserDefaults.standard.integer(forKey: "tipPercentage2"))%", forSegmentAt: 1)
        tipControl.setTitle("\(UserDefaults.standard.integer(forKey: "tipPercentage3"))%", forSegmentAt: 2)
        calculateTip(self)
    }

    
    override func viewDidDisappear(_ animated: Bool) {
//  this func is not called when I swap the whole app up
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
//        show 'Split the bill' section
    }
    

    
    @IBAction func resetButtonTapped(_ sender: Any) {
        billAmountTextfield.text = nil
        tipControl.selectedSegmentIndex = 0
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billAmountTextfield.becomeFirstResponder()
        billPerFriend.text = ""

        //also clear the memory:
        UserDefaults.standard.set(nil, forKey: "billAmount")
        UserDefaults.standard.set(0, forKey: "tipChoice")
        
    }

    @IBAction func calculateTip(_ sender: Any) {
        //retrieve the tipPercentage values from setting page (if edited)
        let t1 = Double(UserDefaults.standard.integer(forKey: "tipPercentage1")) / 100
        let t2 = Double(UserDefaults.standard.integer(forKey: "tipPercentage2")) / 100
        let t3 = Double(UserDefaults.standard.integer(forKey: "tipPercentage3")) / 100
        
        let tipPercentages = [t1,t2,t3] //inject the values to SegmentControl
        
        //Calculate the tip and the total
        let bill = Double(billAmountTextfield.text!) ?? 0
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        //Split the bill:
        let personIcon = ["🙎‍♀️","👱","👩🏻‍💼","👨🏾‍🦳","👨🏻‍🦰","👩‍🎤","👨🏻‍🦱","🧒","👨🏼","🧑‍🦰","👦🏾","👩🏾‍🦳","👨🏻‍🦳","👦🏻","👱🏻‍♀️","👱🏾‍♀️","🙎🏼‍♂️","👨🏻‍⚕️","👨🏽‍⚕️","👴","👩‍🦱"]
        let headCount = Int(friendNumSlider.value)
        
        if headCount == 1 {
            numOfFriends.text = String("It's okay to eat alone 😎")
            img.text = "🍽"
        } else {
            numOfFriends.text = String("\(headCount) friends")
            img.text = ""
            for _ in 1...headCount {
                img.text?.append(personIcon[Int.random(in: 0...20)])
            }
            
        }
        
        let billpf = total / Double(headCount)
        billPerFriend.text = String(format: "$%.2f per friend", billpf)
        
        //store the results (for the user may come back in 10min)
        UserDefaults.standard.set(billAmountTextfield.text!, forKey: "billAmount")
        
        let tipChoice = Int(tipControl.selectedSegmentIndex)
        UserDefaults.standard.set(tipChoice, forKey: "tipChoice")
        
        UserDefaults.standard.set(headCount, forKey: "headCount")
        
        let lastCalculationTime : Date = Date.init()
        UserDefaults.standard.setValue(lastCalculationTime, forKey: "lastCalculationTime")
    }
    
}



