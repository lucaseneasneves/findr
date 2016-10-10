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

open class BeaconController: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = BeaconController()
    
    let locationManager = CLLocationManager()
    
    let advertisingBeacon = AdvertisingBeacon()
    let rangingBeacon = RangingBeacon()
    
    fileprivate override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func startRanging(_ beaconRegion: CLBeaconRegion!){
        beaconRegion.notifyEntryStateOnDisplay = true
        self.rangingBeacon.startRanging(inRegion: beaconRegion, usingLocationManager: self.locationManager)
    }
    
    func stopRanging(_ beaconRegion: CLBeaconRegion!)  {
        self.rangingBeacon.stopRanging(inRegion: beaconRegion, locationManager: self.locationManager)
    }
    
    // CLLocationManagerDelegate Delegates
    
    open func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region: \(error.localizedDescription)")
    }
    
    open func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error.localizedDescription)")
    }
    
    open func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        //print("Region Major: \(region.major!) + Region Minor: \(region.minor!) + Region: \(region.proximityUUID.UUIDString)")
        
        for beacon in beacons {
            print(beacon.fullDetails())
        }
    }
}
