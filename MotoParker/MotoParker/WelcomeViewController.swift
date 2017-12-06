//
//  ViewController.swift
//  MotoParker
//
//  Created by Yahor Yuzefovich on 12/3/17.
//  Copyright © 2017 Yahor Yuzefovich. All rights reserved.
//

import UIKit
import CoreLocation

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        
        let manager = CLLocationManager()
        if !CLLocationManager.locationServicesEnabled()
        {
            //ask for user’s location
            manager.requestWhenInUseAuthorization()
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ContinueButtonWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "WelcomeToParking", sender: sender)
    }
    
}

