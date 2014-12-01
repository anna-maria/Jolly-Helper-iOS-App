//
//  DetailsController.swift
//  Secret Santa
//
//  Created by Anna Gyergyai on 2014-11-26.
//  Copyright (c) 2014 Anna Gyergyai. All rights reserved.
//

import UIKit

class DetailsController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var toPass: String!
    var items:[String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "detailCell")
        
        let handler = {
            (list: [String : String]) -> Void in
            self.items = list
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
        self.getList(handler)
        
        self.tableView.estimatedRowHeight = 190
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("detailCell") as UITableViewCell
        
        cell.textLabel.text = Array(self.items.keys)[indexPath.row]
        cell.detailTextLabel?.text = Array(self.items.values)[indexPath.row]
        //cell.imageView.image = UIImage(named: "giftbox")
        
        return cell
    }

    func getList(handler:([String : String] -> Void))-> [String : String] {
        let url = NSURL(string: "https://jolly-helper-staging.herokuapp.com/persons/\(toPass)/list")!
        var itemList:[String : String] = [:]
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            
            var jsonErrorOptional: NSError?
            let jsonOptional:AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonErrorOptional)
            
            var jsonArray = jsonOptional as NSArray
            
            for var index = 0; index < jsonArray.count ; ++index {
                var title = jsonOptional[index]["title"] as String
                itemList.updateValue(jsonOptional[index]["description"] as String, forKey: title)
            }

            
            handler(itemList)
        }
        
        task.resume()
        
        return itemList
    }
}
