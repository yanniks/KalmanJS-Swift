//
//  KalmanJS.swift
//  KalmanJS
//
// Copyright 2019 Wouter Bulten, Yannik Ehlert
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

open class KalmanFilter {
    /// Set the process noise R
    public var processNoise: Double
    
    /// measurement noise Q
    public var measurementNoise: Double
    
    private let stateVector: Double
    private let controlVector: Double
    private let measurementVector: Double
    
    private var covariance: Double? = nil
    private var estimatedSignal: Double? = nil
    
    /// Create 1-dimensional kalman filter
    ///
    /// - Parameters:
    ///   - processNoise: Process noise
    ///   - measurementNoise: Measurement noise
    ///   - stateVector: State vector
    ///   - controlVector: Control vector
    ///   - measurementVector: Measurement vector
    public init(processNoise: Double = 1.0, measurementNoise: Double = 1.0, stateVector: Double = 1.0, controlVector: Double = 0.0, measurementVector: Double = 1) {
        self.processNoise = processNoise
        self.measurementNoise = measurementNoise
        self.stateVector = stateVector
        self.controlVector = controlVector
        self.measurementVector = measurementVector
    }
    
    /// Filter a new value
    ///
    /// - Parameters:
    ///   - measurement: Measurement
    ///   - control: Control
    /// - Returns: New filter value
    public func filter(measurement: Double, control: Int = 0) -> Double {
        if (self.estimatedSignal == nil) {
            self.estimatedSignal = (1 / self.measurementVector) * measurement
            self.covariance = (1 / self.measurementVector) * self.measurementNoise * (1 / self.measurementVector)
        } else {
            // Compute prediction
            
            let predSignal = self.predict(control: control)!
            let predCov = self.uncertainty!
            
            // Kalman gain
            let gain = predCov * self.measurementVector * (1 / ((self.measurementVector * predCov * self.measurementVector) + self.measurementNoise))
            
            // Correction
            self.estimatedSignal = predSignal + gain * (measurement - (self.measurementVector * predSignal))
            self.covariance = predCov - (gain * self.measurementVector * predCov)
        }
        return self.estimatedSignal!
    }
    
    /// Predict next value
    ///
    /// - Parameter control: Control
    /// - Returns: Predicted value
    public func predict(control: Int = 0) -> Double? {
        guard let estimation = self.estimatedSignal else {
            // Return nil if there is no estimation set
            return nil
        }
        return (self.stateVector * estimation) + (self.controlVector * Double(control))
    }
    
    /// Return uncertainty of filter. `nil` in case no covariance was set.
    public var uncertainty: Double? {
        guard let cov = self.covariance else {
            return nil
        }
        return ((self.stateVector * cov) * self.stateVector) + self.processNoise
    }
    
    /// last filtered measurement
    public var lastMeasurement: Double? {
        return self.estimatedSignal
    }
}
