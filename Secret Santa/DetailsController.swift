//
//  DetailsController.swift
//  Secret Santa
//
//  Created by Anna Gyergyai on 2014-11-26.
//  Copyright (c) 2014 Anna Gyergyai. All rights reserved.
//

import UIKit

class DetailsController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    let items:[String] = ["this", "is", "my", "list"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("detailCell") as UITableViewCell
        
        cell.textLabel.text = self.items[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }

}
