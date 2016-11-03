//
//  Beacon.swift
//  iBeacons
//
//  Created by Jonathan Nobre on 9/2/16.
//  Copyright © 2016 JNF. All rights reserved.
//

import Foundation
import CoreLocation

open class Beacon: NSObject {
    let identifier: String
    let uuid: UUID
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    
    public init(identifier: String, uuid: UUID, majorValue: CLBeaconMajorValue, minorValue: CLBeaconMinorValue) {
        self.identifier = identifier
        self.uuid = uuid
        self.majorValue = majorValue
        self.minorValue = minorValue
    }
    
    open func getRegion() -> CLBeaconRegion {
        let region =  CLBeaconRegion(proximityUUID: self.uuid, major: self.majorValue, minor: self.minorValue, identifier: self.identifier)
        return region
    }
}

// MARK: - CLBeacon extension
public extension CLBeacon
{
    /**
     Returns a specially-formatted description of the beacon's characteristics.
     
     :returns: The beacon's description.
     */
    public func fullDetails() -> String {
        let proximityText: String
        
        switch proximity {
        case .near:
            proximityText = "Near"
        case .immediate:
            proximityText = "Immediate"
        case .far:
            proximityText = "Far"
        case .unknown:
            proximityText = "Unknown"
        }
        
        return "\(major), \(minor) •  \(proximityText) • \(accuracy) • \(rssi)"
    }
}
