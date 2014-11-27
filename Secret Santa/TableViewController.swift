//
//  TableViewController.swift
//  Secret Santa
//
//  Created by Anna Gyergyai on 2014-11-24.
//  Copyright (c) 2014 Anna Gyergyai. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let handler = {
            (list: [String]) -> Void in
            self.items = list
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
        self.getPeople(handler)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.items.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel.text = self.items[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //go to details page
        dispatch_async(dispatch_get_main_queue()) {
            let vc: AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("DetailsController")
            self.showViewController(vc as UIViewController, sender: vc)
        }
    }
    
    func getPeople(handler:([String] -> Void))-> [String] {
        let url = NSURL(string: "https://jolly-helper.herokuapp.com/persons")!
        var nameList:[String] = []
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            
            var jsonErrorOptional: NSError?
            let jsonOptional: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonErrorOptional)

            var jsonArray = jsonOptional as NSArray
            
            for var index = 0; index < jsonArray.count ; ++index {
                nameList.append(jsonOptional[index]["name"] as String)
            }
            
            handler(nameList)
        }
    
        task.resume()

        return nameList
    }

}