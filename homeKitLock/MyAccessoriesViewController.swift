//
//  MyAccessoriesViewController.swift
//  homeKitLock
//
//  Created by Thomas Houghton on 14/08/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit
import HomeKit

class MyAccessoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var accessories = [HMAccessory]()
    var amountOfAccessories = 0
    let homeManager = HMHomeManager()
    
    // Mark: View Setup Stuff.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("All the accessories in the home \(homeManager.primaryHome?.accessories.count)")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        amountOfAccessories = homeManager.primaryHome!.accessories.count
        tableView.reloadData()
    }
    
    // MARK: Table View Stuff.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalAccessories = homeManager.primaryHome!.accessories.count
        return totalAccessories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let accessory = homeManager.primaryHome!.accessories[indexPath.row]
        cell.textLabel?.text = accessory.name
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
