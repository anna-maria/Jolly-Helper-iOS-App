//
//  PageViewController.swift
//  Secret Santa
//
//  Created by Anna Gyergyai on 2014-11-19.
//  Copyright (c) 2014 Anna Gyergyai. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var listOfViewControllers: [UIViewController]!
    
    var pageViewController: UIPageViewController!
    var currentViewController: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // self is a UIPageViewController
        var storyboard: UIStoryboard  = UIStoryboard(name: "Main", bundle:nil)
        var firstVC = storyboard.instantiateViewControllerWithIdentifier("NavigationTwoController") as UIViewController
        var secondVC = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as UIViewController
        
        // make a store for all of our ViewControllers
        self.listOfViewControllers = [firstVC,secondVC];
        
        // setup initial viewcontroller
        self.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward , animated: false, completion:nil)
        //[self setViewControllers:@[firstVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        self.delegate = self
        self.dataSource = self
        
        self.view.tintColor = UIColor.orangeColor()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        // since we only have two ViewControllers for this project, we will compare with kindofclass of the passed 'viewcontroller' parameter to define
        // what's next.
        var index: NSInteger? = self.indexOfViewController(viewController)
        
        // this shouldn't happen, but if it does, give UIPageViewController firstVC
        if let val = index {
            if (val == 0){
                return nil
            }else{
                return self.listOfViewControllers[val-1]
            }
        }
        
        return nil
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index: NSInteger? = self.indexOfViewController(viewController)
        
        if let val = index {
            if (val == self.listOfViewControllers.count-1){
                return nil
            }else{
                return self.listOfViewControllers[val+1]
            }
        }
        return nil;
    }
    
    func indexOfViewController (viewController:UIViewController) -> NSInteger? {
        return find(self.listOfViewControllers, viewController)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        if let val = self.indexOfViewController(pageViewController.viewControllers.first as UIViewController) {
            return val
        }else{
            return 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
