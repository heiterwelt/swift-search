//
//  ViewController.swift
//  人工sadgeg
//
//  Created by Linyou-IOS-1 on 16/5/5.
//  Copyright © 2016年 MuYou INTERACTIVE TECHNOLOGY LIMITED. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UISearchResultsUpdating{

    var tableview: UITableView?
    
   // var search:UISearchBar?
    
    var searchController:UISearchController?
    
    
    var allcity: NSMutableArray?
    var searchcity:NSMutableArray?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview = UITableView(frame: CGRectMake(0, 90, view.frame.size.width, view.frame.size.height-90), style: .Grouped)
        view.addSubview(tableview!)
    
        allcity = ["beijing","najing","hangzhou","wuhan","shenzhen"]
        searchcity = NSMutableArray()
//        self.search = UISearchBar(frame:CGRectMake(0, 70, view.frame.size.width, 20) )
//        self.view.addSubview(self.search!)
//        
        tableview!.dataSource=self
        tableview!.delegate=self
        tableview?.backgroundColor=UIColor.redColor()
        
//        search?.showsCancelButton=true
//        search?.barStyle = .BlackTranslucent
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchResultsUpdater=self
        self.searchController!.dimsBackgroundDuringPresentation = false;
        self.searchController!.searchBar.sizeToFit()
        self.searchController?.searchBar.showsCancelButton=true
        self.searchController!.searchBar.backgroundColor = UIColor.blueColor()
        self.tableview!.tableHeaderView = self.searchController!.searchBar

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.searchController!.active {
            self.searchController!.active = false
            self.searchController!.searchBar.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !(searchController?.active)! {
            return (allcity?.count)!

        }else
        {
            if searchcity == nil {
                return 1
            }else{
                return (searchcity?.count)!}
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if !(searchController?.active)! {
            return 4
        }else{
            return 1;
        }
      
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "identifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: ID)
            
        }
        if !(searchController?.active)!{
             cell?.textLabel?.text = allcity![indexPath.row] as? String
            
        }
        else{
            if (searchcity != nil) {
                 cell?.textLabel?.text = searchcity![indexPath.row] as? String
            }else{
                cell?.textLabel?.text="";
            }
           

        }

        
        
        return cell!
        
        
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        var str:String?
        
        if section == 0 {
            str = "A"
        }
        if section == 1  {
            str = "B"
        }
        
        
        
       return str
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
       self.searchcity?.removeAllObjects()
        
//        var searchPredicate: NSPredicate  = NSPredicate.predicateWithFormat:"SELF CONTAINS[c] %@", self.searchController.searchBar.text
//        
     let searchPredicate: NSPredicate  =   NSPredicate.init(format: "SELF CONTAINS[c] %@", self.searchController!.searchBar.text!)
//        if (searchController.searchBar.text != nil) {
//            for Str in self.allcity! {
//                
//                
//                if Str.containsObject(searchController.searchBar.text) {
//                    self.searchcity?.addObject(Str)
//                }
//            }
//        }
        
        let arr:NSArray = self.allcity!.filteredArrayUsingPredicate(searchPredicate)
        
        
        self.searchcity?.addObjectsFromArray(arr as [AnyObject])
        
       // self.searchcity?.addObjectsFromArray( self.allcity?.filterUsingPredicate(searchPredicate))

        
       
        dispatch_async(dispatch_get_main_queue()) { 
            self.tableview?.reloadData()
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50;
    }

}

