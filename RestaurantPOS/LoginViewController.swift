//
//  LoginViewController.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/5/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("You are logged in")
                print(user?.username)
                //self.performSegueWithIdentifier("mainscreen", sender: nil)
                
                if user?.username=="manager"{
                    self.performSegueWithIdentifier("manager", sender: nil)
                }else if user?.username=="staff"{
                    self.performSegueWithIdentifier("staff", sender: nil)
                }else if user?.username=="chef"{
                    self.performSegueWithIdentifier("chef", sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                //self.performSegueWithIdentifier("mainscreen", sender: nil)
                print(newUser.username)
                if newUser.username=="manager"{
                    self.performSegueWithIdentifier("manager", sender: nil)
                }else if newUser.username=="staff"{
                    self.performSegueWithIdentifier("staff", sender: nil)
                }else if newUser.username=="chef"{
                    self.performSegueWithIdentifier("chef", sender: nil)
                }
            }
        }
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
