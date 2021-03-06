//
//  ReferenceValues.swift
//  Driving behaviour analyzer
//
//  Created by Przemysław Kuzia on 30.01.2018.
//  Copyright © 2018 Pkuzia. All rights reserved.
//

import Foundation

class ReferenceValues {
    
    // MARK: - Reference Constans
    
    static let maxVehicleSpeedRatio: Int = 5
    static let minVehicleSpeedRatio: Int = -10
    
    static let maxEngineSpeedRatio: Int = 500
    static let maxEngineLoad: Float = 80.0
    
    static let minVehicleEngineSpeedRatio: Float = 0.5
    static let maxVehicleEngineSpeedRatio: Float = 1.5
    
    static let maxFuelRailPressure: Float = 4.0
    
    static let firstScoreCeil: Double = 5.0
    static let secondScoreCeil: Double = 10.0
    static let thirdScoreCeil: Double = 15.0
    
}
