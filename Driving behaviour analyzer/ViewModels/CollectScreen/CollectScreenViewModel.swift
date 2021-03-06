//
//  CollectScreenViewModel.swift
//  Driving behaviour analyzer
//
//  Created by Przemysław Kuzia on 26.12.2017.
//Copyright © 2017 Pkuzia. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

protocol CollectScreenViewModelDelegate: class {
    
}

enum ConnectionState {
    case notConnected, connected
}

class CollectScreenViewModel: BaseViewModel {
    
    // MARK: - Strings
    
    let screenTitle = "collect_screen_title".localized
    
    let vehicleSpeedLabel = "vehicle_speed_label".localized
    let engineLoadLabel = "engine_load_label".localized
    let engineSpeedLabel = "engine_speed_label".localized
    let fuelRailPressureLabel = "fuel_rail_pressure_label".localized
    
    let connectionStateNotConnected = "connection_state_not_connected".localized
    let connectionStateConnected = "connection_state_connected".localized
    let connectionStateOpeningConnection = "connection_state_opening_connection".localized
    let connectionStateInit = "connection_state_initializing".localized
    
    let emptyValuePlaceholder = "-"
    
    let alertTitle = "connection_start_label_title".localized
    let alertSubtitle = "connection_start_label_subtitle".localized
    let alertPlaceholder = "connection_start_placeholder".localized
    let alertSaveButton = "connection_start_save_button".localized
    let clearDataButton = "connection_clear_data_button".localized
    
    // MARK: - View Model Data
    
    let obdIIService = OBDIIService()
    
    weak var delegate: CollectScreenViewModelDelegate?
    var connectionState: ConnectionState = .notConnected
    var userCurrentCoordinates: CLLocationCoordinate2D?
    
    // MARK: - Functions
    
    override init() {
        super.init()
        setOBDIIServiceDelegate()
    }
    
    fileprivate func setOBDIIServiceDelegate() {
        obdIIService.obdIILocationProviderDelegate = self
    }
    
    func clearData() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch _ {
            
        }
    }
}

// MARK: - OBDIILocationProviderDelegate

extension CollectScreenViewModel: OBDIILocationProviderDelegate {
    func currentLocation() -> CLLocationCoordinate2D? {
        return userCurrentCoordinates
    }
}

