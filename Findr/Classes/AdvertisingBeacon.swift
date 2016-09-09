//
//  AdvertisingBeacon.swift
//  iBeacons
//
//  Created by Jonathan Nobre on 9/3/16.
//  Copyright © 2016 JNF. All rights reserved.
//

import Foundation
import CoreBluetooth

/// Lists the methods that an advertising delegate should implement to be notified for all advertising operation events.
public protocol BeaconAdvertisingDelegate {
    /**
     Triggered when the advertising operation has started successfully.
     */
    func advertisingOperationDidStartSuccessfully()
    
    /**
     Triggered by the advertising operation when it has stopped successfully.
     */
    func advertisingOperationDidStopSuccessfully()
    
    /**
     Triggered when the advertising operation has failed to start.
     */
    func advertisingOperationDidFailToStart()
}

public class AdvertisingBeacon: NSObject, CBPeripheralManagerDelegate {
    
    /// An instance of a CBPeripheralManager, which is used for advertising a beacon to nearby devices.
    var peripheralManager = CBPeripheralManager(delegate: nil, queue: nil, options: nil)
    
    var delegate: BeaconAdvertisingDelegate?
    
    func startAdvertising() {
        print("Starting Advertising")
        self.peripheralManager.delegate = self
    }
    
    func broadcast(beacon: Beacon!) {
        let beaconPeripheralData: NSDictionary = beacon.getRegion().peripheralDataWithMeasuredPower(nil) as NSDictionary
        self.peripheralManager.startAdvertising(beaconPeripheralData as? [String : AnyObject])
    }
    
    func stopBroadcast() {
        print("Turned off advertising.")
        
        self.peripheralManager.stopAdvertising()
        delegate?.advertisingOperationDidStopSuccessfully()
    }
    
    /// CBPeripheralManagerDelegate Delegates
    
    public func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        if error != nil {
            print("Couldn't turn on advertising: \(error)")
            delegate?.advertisingOperationDidFailToStart()
        }
        
        if peripheralManager.isAdvertising {
            print("Turned on advertising.")
            delegate?.advertisingOperationDidStartSuccessfully()
        }
    }
    
    public func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        if peripheralManager.state == .PoweredOff {
            print("Peripheral manager is off.")
            delegate?.advertisingOperationDidFailToStart()
        } else if peripheralManager.state == .PoweredOn {
            print("Peripheral manager is on.")
        }
    }
    
}