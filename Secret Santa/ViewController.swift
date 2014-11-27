//
//  ViewController.swift
//  Secret Santa
//
//  Created by Anna Gyergyai on 2014-11-15.
//  Copyright (c) 2014 Anna Gyergyai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var NameLabel: UILabel! = nil
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var AgeLabel: UILabel! = nil
    @IBOutlet var AgeTextField: UITextField!
    @IBOutlet var EmailLabel: UILabel! = nil
    @IBOutlet var EmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitSecretSanta(sender: UIButton) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://jolly-helper.herokuapp.com/persons")!)
        
        
        var session = NSURLSession.sharedSession()
        
        //var params = ["email":"\(usenNameTF.text)", "password":"\(passwordTF.text)"] as Dictionary
        var params = ["name":"\(NameTextField.text)", "email":"\(EmailTextField.text)", "age": "\(AgeTextField.text)"] as Dictionary
        
        
        
        var err: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        request.HTTPMethod = "POST"
        
        var task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            println("Response: \(response)")
            
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            println("Body: \(strData)\n\n")
            
            var err: NSError?
            
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSArray
            
            // json = {"response":"Success","msg":"User login successfully."}
            if(err != nil) {
                
                println(err!.localizedDescription)
                
            }
                
            else {
                
                //success! user added to secret santa
                
                dispatch_async(dispatch_get_main_queue()) {
                    var refreshAlert = UIAlertController(title: "Congrats!", message: "Thanks for joining! You'll be receiving an email shortly with your secret santa!", preferredStyle: UIAlertControllerStyle.Alert)
                
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                        println("Handle Ok logic here")
                        let vc: AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController")
                        self.showViewController(vc as UIViewController, sender: vc)
                    }))
                
                    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                        println("Handle Cancel Logic here")
                    }))
                
                    self.presentViewController(refreshAlert, animated: true, completion: nil)
                }
                
            }
            
        })
        
        task.resume()

    }
}

