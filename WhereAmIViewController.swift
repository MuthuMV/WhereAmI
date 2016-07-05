//
//  WhereAmIViewController.swift
//  WhereAmI
//
//  Created by Muthu Venkatesh on 5/20/16.
//  Copyright © 2016 Muthu Venkatesh. All rights reserved.
//

import UIKit

class WhereAmIViewController: UIViewController {

    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var speed: UILabel!
    
    @IBOutlet weak var altitude: UILabel!
    
    var locationDetails = ViewController()

    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Value passed... \(String(locationDetails.userLocation.coordinate.latitude))")
        let latitude = String(locationDetails.userLocation.coordinate.latitude)
        let longitude = String(locationDetails.userLocation.coordinate.longitude)
        let address = locationDetails.userAddress
        print(locationDetails.userLocation.speed)
        let speed = String(locationDetails.userLocation.speed)
        let altitude = String(locationDetails.userLocation.altitude)
        
        location.text = "\(latitude), \(longitude)"
        self.address.text = "\(address)"
        self.speed.text = "\(speed)"
        self.altitude.text = "\(altitude)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
