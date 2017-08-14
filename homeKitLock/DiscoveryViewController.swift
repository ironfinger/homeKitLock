//
//  ViewController.swift
//  homeKitLock
//
//  Created by Thomas Houghton on 14/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class DiscoveryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HMAccessoryBrowserDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let homeManager = HMHomeManager()
    let browser = HMAccessoryBrowser()
    let discoveryTimer = Timer()
    
    var accessories = [HMAccessory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Searching")
        
        browser.delegate = self
        
        // Start the device search process.
        browser.startSearchingForNewAccessories()
        
        
        // Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (timer) in
            // print(timer)
        // }
    }
    
    // MARK: - Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accessories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        // if let cell = tableView.dequeueReusableCell(withIdentifier: "accessoryId") {
            // let accessory = accessories[indexPath.row] as HMAccessory
            // cell.textLabel?.text = accessory.name
            // return cell
        // }
        // return UITableViewCell()
        
        let accessory = accessories[indexPath.row] as HMAccessory
        cell.textLabel?.text = accessory.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected the row")
        let accessory = accessories[indexPath.row] as HMAccessory
        print(accessory.name)
        
        if let room = homeManager.primaryHome?.rooms.first as HMRoom? {
            homeManager.primaryHome?.addAccessory(accessory, completionHandler: { (error) in
                if error != nil {
                    print("We have an error \(error)")
                }else{
                    self.homeManager.primaryHome?.assignAccessory(accessory, to: room, completionHandler: { (error) in
                        if error != nil {
                            print("We have an error with assigning the accessory to a room: \(error)")
                        }else{
                            print("accessory assigned")
                        }
                    })
                }
            })
            print("Accessory assigned")
        }
    }
    
    // MARK: - Accessory Delegate
    
    // Is called when a new accessory is found, then adds that accessory to the array.
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didFindNewAccessory accessory: HMAccessory) {
        accessories.append(accessory)
        tableView.reloadData()
    }
    
    func accessoryBrowser(_ browser: HMAccessoryBrowser, didRemoveNewAccessory accessory: HMAccessory) {
        var index = 0
        for item in accessories {
            if item.name == accessory.name {
                accessories.remove(at: index)
                break;
            }
            index = index + 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

