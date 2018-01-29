//
//  CollectTableViewCalculatedViewModel.swift
//  Driving behaviour analyzer
//
//  Created by Przemysław Kuzia on 28.01.2018.
//  Copyright © 2018 Pkuzia. All rights reserved.
//

import UIKit
import RealmSwift

protocol CollectTableViewCalculatedViewModelDelegate: class {
    
}

class CollectTableViewCalculatedViewModel: BaseViewModel {
    
    // MARK: - Strings
    
    // MARK: - View Model Data
    
    let calculatedDataCellID = "calculatedDataCell"
    let calculatedDataHeaderID = "calculatedDataHeader"
    let screenTitle = "collect_calculated_table_view_title".localized
    
    var driveItemData: [DriveItemData] = []
    var calculatedData: [CalculatedDriveItem] = []
    
    let calculatedDataCellSize: CGFloat = 125
    let calculatedDataHeaderSize: CGFloat = 55
    
    weak var delegate: CollectTableViewCalculatedViewModelDelegate?
    
    // MARK: - Functions
    
    func processData(completionHandler: (_ complete: Bool) -> ()) {
        fetchData { complete in
            if complete {
                var index = 0
                while let item = driveItemData.item(at: index) {
                    appendDriveItemData(item: item, index: index)
                    index += 4
                }
                calculateEngineVehicleSpeedDeltaRatio()
            }
        }
    }
    
    fileprivate func fetchData(completionHandler: (_ complete: Bool) -> ()) {
        do {
            let realm = try Realm()
            driveItemData = Array(realm.objects(DriveItemData.self))
            completionHandler(true)
        } catch _ {
            print("Fetch data failed.")
            completionHandler(false)
        }
    }
    
    fileprivate func appendDriveItemData(item: DriveItemData, index: Int) {
        var vehicleSpeed: Float?
        var engineSpeed: Float?
        var engineLoad: Float?
        var fuelRailPressure: Float?
        
        if item.dataTypeEnum == .vehicleSpeed {
            vehicleSpeed = item.value
        }
        
        if let nextItem = driveItemData.item(at: index + 1), nextItem.dataTypeEnum == .engineSpeed {
            engineSpeed = nextItem.value
        }
        
        if let nextItem = driveItemData.item(at: index + 2), nextItem.dataTypeEnum == .engineLoad {
            engineLoad = nextItem.value
        }
        
        if let nextItem = driveItemData.item(at: index + 3), nextItem.dataTypeEnum == .fuelRailPressure {
            fuelRailPressure = nextItem.value
        }
        if let vehicleSpeed = vehicleSpeed, let engineSpeed = engineSpeed, let engineLoad = engineLoad, let fuelRailPressure = fuelRailPressure {
            let calculatedDriveItem = CalculatedDriveItem(engineSpeed: engineSpeed.int, vehicleSpeed: vehicleSpeed.int, engineLoad: engineLoad,
                                                           fuelRailPressure: fuelRailPressure.int, timestamp: item.timestamp, position: (lat: item.lat, lng: item.lng))
            //TODO: Mock
            calculatedDriveItem.calculateVehicleEngineSpeedRatio(maxVehicleSpeed: 180, maxRPM: 4500)
            calculatedData.append(calculatedDriveItem)
        }
    }
    
    fileprivate func calculateMaxDeltaValues() -> (maxDeltaRPM: Float, maxDeltaVehicleSpeed: Float) {
        var maxDeltaRPM = 0
        var maxDeltaVehicleSpeed = 0
        
        var index = 1
        while let currentItem = calculatedData.item(at: index), let previousItem = calculatedData.item(at: index - 1) {
            let currentDeltaRPM = currentItem.engineSpeed - previousItem.engineSpeed
            currentItem.engineSpeedDelta = currentDeltaRPM
            if currentDeltaRPM > maxDeltaRPM {
                maxDeltaRPM = currentDeltaRPM
            }
            
            let currentVehicleSpeed = currentItem.vehicleSpeed - previousItem.vehicleSpeed
            currentItem.vehicleSpeedDelta = currentVehicleSpeed
            if currentVehicleSpeed > maxDeltaVehicleSpeed {
                maxDeltaVehicleSpeed = currentVehicleSpeed
            }
            
            index += 1
        }
        return (maxDeltaRPM: maxDeltaRPM.float, maxDeltaVehicleSpeed: maxDeltaVehicleSpeed.float)
    }
    
    fileprivate func calculateEngineVehicleSpeedDeltaRatio() {
        let (maxDeltaRPM, maxDeltaVehicleSpeed) = calculateMaxDeltaValues()
        calculatedData.forEach { item in
            item.calculateEngineVehicleSpeedRatio(maxDeltaRPM: maxDeltaRPM, maxDeltaVehicleSpeed: maxDeltaVehicleSpeed)
        }
    }
}

