//
//  LocationServiceTests.swift
//
//  Copyright (c) 2017 OpenLocate
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import XCTest
@testable import OpenLocate
import CoreLocation

class LocationRequestTests: BaseTestCase {

    func testIsLocationServiceEnabled() {
        // Given
        let enabled = LocationService.isEnabled()

        // Then
        XCTAssertTrue(enabled)
    }

    func testLocationServiceStart() {
        // Given
        let mockLocationManager = MockCLLocationManager()
        let locationManager = LocationManager(manager: mockLocationManager)
        let locationService = LocationService(
            postable: HttpClient(baseUrl: "https://httpbin.org", urlSession: SuccessURLSession()),
            writeable: TcpClient(host: "1.2.3.4", port: 1234, session: SuccessTcpSession()),
            locationDataSource: LocationList(),
            logger: ConsoleLogger(logLevel: .info),
            scheduler: TaskScheduler(),
            providerId: UUID(uuidString: "123e4567-e89b-12d3-a456-426655440000")!,
            token: "1234",
            advertisingInfo: AdvertisingInfo.Builder()
                .set(advertisingId: "1234")
                .set(isLimitedAdTrackingEnabled: true)
                .build(),
            locationManager: locationManager
        )
        let location = CLLocation(latitude: 12.43, longitude: 124.43)

        // When
        locationService.start()
        locationManager.locationManager(CLLocationManager(), didUpdateLocations: [location])

        // Then
        XCTAssertTrue(true)
    }

    func testLocationServiceStop() {
        // Given
        let mockLocationManager = MockCLLocationManager()
        let locationManager = LocationManager(manager: mockLocationManager)
        let locationService = LocationService(
            postable: HttpClient(baseUrl: "https://httpbin.org", urlSession: SuccessURLSession()),
            writeable: TcpClient(host: "1.2.3.4", port: 1234, session: SuccessTcpSession()),
            locationDataSource: LocationList(),
            logger: ConsoleLogger(logLevel: .info),
            scheduler: TaskScheduler(),
            providerId: UUID(uuidString: "123e4567-e89b-12d3-a456-426655440000")!,
            token: "1234",
            advertisingInfo: AdvertisingInfo.Builder()
                .set(advertisingId: "1234")
                .set(isLimitedAdTrackingEnabled: true)
                .build(),
            locationManager: locationManager
        )
        let location = CLLocation(latitude: 12.43, longitude: 124.43)

        // When
        locationService.start()
        locationManager.locationManager(CLLocationManager(), didUpdateLocations: [location])
        locationService.stop()

        // Then
        XCTAssertTrue(true)
    }
}