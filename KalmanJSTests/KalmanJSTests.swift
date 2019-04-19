//
//  KalmanJSTests.swift
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

import XCTest
@testable import KalmanJS

class Kalman_FilterTests: XCTestCase {
    var kalmanInstance: KalmanFilter? = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.kalmanInstance = KalmanFilter()
    }

    func testSimpleKarmanResult() {
        XCTAssertEqual(kalmanInstance?.filter(measurement: 3), 3, "First Kalman result is not three.")
        XCTAssertEqual(kalmanInstance?.filter(measurement: 2), 7/3, "Second Kalman result is not 2 1/3.")
        XCTAssertEqual(kalmanInstance?.filter(measurement: 1), 1.5000000000000002, "Third Kalman result is not approx. 1.5.")
    }
}
