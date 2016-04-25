//
//  ManagerFirst.swift
//  RestaurantPOS
//
//  Created by Parth Bhardwaj on 4/6/16.
//  Copyright © 2016 TheThreeNoobs. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD



class ManagerFirst: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menuTable: UITableView!
    var posts: [PFObject]?

    func loadDataFromNetwork() {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        
        showMenu()
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(showMenu(),
                                                                      completionHandler: { (data, response, error) in
                                                                        
                                                                        // Hide HUD once the network request comes back (must be done on main UI thread)
                                                                        MBProgressHUD.hideHUDForView(self.view, animated: true)
                                                                        
                                                                        // ... Remainder of response handling code ...
                                                                        
        });
        task.resume()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuTable.delegate = self
        menuTable.dataSource = self
        self.menuTable.reloadData()
        
        
       // showMenu()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showMenu() {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.posts = posts
                self.menuTable.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuTableViewCell
        cell.menuPost = posts![indexPath.row]
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }

    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogoutNotification", object: nil)
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
