//
//  BeaconController.swift
//  iBeacons
//
//  Created by Jonathan Nobre on 9/3/16.
//  Copyright © 2016 JNF. All rights reserved.
//

import Foundation
import CoreLocation

public protocol BeaconDelegate {
    
}

public class BeaconController: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = BeaconController()
    
    let locationManager = CLLocationManager()
    
    let advertisingBeacon = AdvertisingBeacon()
    let rangingBeacon = RangingBeacon()
    
    private override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func startRanging(beaconRegion: CLBeaconRegion!){
        beaconRegion.notifyEntryStateOnDisplay = true
        self.rangingBeacon.startRanging(inRegion: beaconRegion, usingLocationManager: self.locationManager)
    }
    
    func stopRanging(beaconRegion: CLBeaconRegion!)  {
        self.rangingBeacon.stopRanging(inRegion: beaconRegion, locationManager: self.locationManager)
    }
    
    // CLLocationManagerDelegate Delegates
    
    public func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print("Failed monitoring region: \(error.description)")
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location manager failed: \(error.description)")
    }
    
    public func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        //print("Region Major: \(region.major!) + Region Minor: \(region.minor!) + Region: \(region.proximityUUID.UUIDString)")
        
        for beacon in beacons {
            print(beacon.fullDetails())
        }
    }
}
