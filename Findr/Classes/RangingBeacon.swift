//
//  RangingBeacon.swift
//  iBeacons
//
//  Created by Jonathan Nobre on 9/3/16.
//  Copyright © 2016 JNF. All rights reserved.
//

import Foundation
import CoreLocation

/// Lists the methods that a ranging delegate should implement to be notified for all ranging operation events.
public protocol RangingDelegate {
    /**
     Triggered when the ranging operation has started successfully.
     */
    func rangingOperationDidStartSuccessfully()
    
    /**
     Triggered when the ranging operation has failed to start.
     */
    func rangingOperationDidFailToStart(reason: String!)
    
    /**
     Triggered when the ranging operation has failed to start due to the last authorization denial.
     */
    func rangingOperationDidFailToStartDueToAuthorization(reason: String!)
    
    /**
     Triggered when the ranging operation has stopped successfully.
     */
    func rangingOperationDidStopSuccessfully()
    
    /**
     Triggered when the ranging operation has detected beacons belonging to a specific given beacon region.
     
     :param: beacons An array of provided beacons that the ranging operation detected.
     :param: region A provided region whose beacons the operation is trying to range.
     */
    func rangingOperationDidRangeBeacons(beacons: [AnyObject]!, inRegion region: CLBeaconRegion!)
}

public class RangingBeacon: NSObject {
    
    var delegate: RangingDelegate?
    
    func startRanging(inRegion region: CLBeaconRegion!, usingLocationManager locationManager: CLLocationManager!) {
        print("Turning on ranging...")
        
        if !CLLocationManager.locationServicesEnabled() {
            delegate?.rangingOperationDidFailToStart("Location services are not enabled.")
            return
        }
        
        if !CLLocationManager.isRangingAvailable() {
            delegate?.rangingOperationDidFailToStart("Ranging is not available.")
            return
        }
        
        if !locationManager.rangedRegions.isEmpty {
            delegate?.rangingOperationDidFailToStart("Didn't turn on ranging: Ranging already on.")
            return
        }
        
        switch CLLocationManager.authorizationStatus() {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                print("Ranging turned on for beacons in region: \(region)")
                
                locationManager.startRangingBeaconsInRegion(region)
                delegate?.rangingOperationDidStartSuccessfully()
            case .Denied, .Restricted:
                delegate?.rangingOperationDidFailToStartDueToAuthorization("Couldn't turn on ranging: Required Location Access (When In Use) missing.")
            case .NotDetermined:
                locationManager.requestWhenInUseAuthorization()
        }
    }
    
    public func stopRanging(inRegion region: CLBeaconRegion!, locationManager: CLLocationManager!)  {
        if locationManager.rangedRegions.isEmpty {
            print("Didn't turn off ranging: Ranging already off.")
            return
        }
        
        locationManager.stopRangingBeaconsInRegion(region)
        
        delegate?.rangingOperationDidStopSuccessfully()
        
        print("Turned off ranging.")
    }
    
}
