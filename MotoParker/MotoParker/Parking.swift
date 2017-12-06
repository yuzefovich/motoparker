//
//  Parking.swift
//  MotoParker
//
//  Created by Yahor Yuzefovich on 12/3/17.
//  Copyright © 2017 Yahor Yuzefovich. All rights reserved.
//

import UIKit
import CoreLocation

var unmetered:[Parking] = []
var metered:[Parking] = []

class Parking {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var spaces: Int
    init(lat: CLLocationDegrees, lon: CLLocationDegrees, space: Int) {
        latitude = lat
        longitude = lon
        spaces = space
    }
}

func loadData() {
    if let path = Bundle.main.path(forResource: "unmetered", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let data = jsonResult["data"] as? [Any] {
                for i in 0...(data.count-1) {
                    if let obj = data[i] as? NSArray, let obj2 = obj[17] as? NSArray {
                        let lat = obj2[1], lon = obj2[2]
                        let spaces = obj[12]
                        unmetered.append(Parking(lat:Double(lat as! String)!, lon:Double(lon as! String)!, space:Int(spaces as! String)!))
                    }
                }
            }
        } catch {
            // handle error
        }
    }
    if let path = Bundle.main.path(forResource: "metered", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let data = jsonResult["data"] as? [Any] {
                for i in 0...(data.count-1) {
                    if let obj = data[i] as? NSArray, let obj2 = obj[24] as? NSArray {
                        let lat = obj2[1], lon = obj2[2]
                        let spaces = obj[11]
                        metered.append(Parking(lat:Double(lat as! String)!, lon:Double(lon as! String)!, space:Int(spaces as! String)!))
                    }
                }
            }
        } catch {
            // handle error
        }
    }
}
