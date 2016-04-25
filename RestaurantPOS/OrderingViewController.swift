//
//  OrderingViewController.swift
//  RestaurantPOS
//
//  Created by Shakeel Daswani on 4/21/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit

var tableNumber:Int!

class OrderingViewController: UIViewController {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var menuNotes: UILabel!
    @IBOutlet weak var menuPrice: UILabel!
    @IBOutlet weak var menuName: UILabel!
    
    @IBOutlet weak var tableNum: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var name: String!
    var price:String!
    var priceNum:Double!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha: 1.0).CGColor

        textView.layer.borderWidth = 1
        
        stepper.value = 1
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 15

        
        self.menuName.text = name
        self.menuPrice.text = price
        
        if (tableNumber != nil){
            tableNum.text=String(tableNumber)
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        amountLabel.text = Int(sender.value).description
        let index1 = price.startIndex.advancedBy(1)
        let substring1 = price.substringFromIndex(index1)
        print(substring1)
        priceNum = Double(substring1)
        
        print(priceNum)
        let quantity=Int(sender.value).description
        print(quantity)
        let newPrice=priceNum*Double(quantity)!
        print(newPrice)
        self.menuPrice.text = "$ \(String(newPrice))"
    }

    @IBAction func addToOrder(sender: AnyObject) {
    }
    
    
    @IBAction func tableChanged(sender: AnyObject) {
        tableNumber = Int(self.tableNum.text!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
