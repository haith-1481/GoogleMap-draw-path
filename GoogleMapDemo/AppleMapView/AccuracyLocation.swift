//
//  AccuracyLocation.swift
//  GoogleMapDemo
//
//  Created by Sean on 06/07/2023.
//

import Foundation
import CoreLocation

extension ViewController: CLLocationManagerDelegate
{
	
	func setupCoreLocation() {
		locationManager.delegate = self
		locationManager.requestAlwaysAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
	}
	
	func startRequestLocation() {
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in 
			// Request a user’s location once
			self?.locationManager.requestLocation()
			if let location = self?.locationHistory {
				self?.drawPlaceMark(location: location)
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let TIMEOUT_INTERVAL = 3.0
//		centerMapOnLocation(location: locations.last!)
		let newLocation = locations.last as! CLLocation
		print("didupdateLastLocation \(newLocation)")
		showToast(message: "\(newLocation)")
//		locationHistory.append(CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude))
		//The last location must not be capured more then 3 seconds ago
		if newLocation.timestamp.timeIntervalSinceNow > -3 &&
			newLocation.horizontalAccuracy > 0 {
			var distance = CLLocationDistance(Double.greatestFiniteMagnitude)
			if let location = self.lastLocation {
				distance = newLocation.distance(from: location)
			}
			if self.lastLocation == nil ||
				self.lastLocation!.horizontalAccuracy > newLocation.horizontalAccuracy {
				self.lastLocation = newLocation
				if newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy {
					//Desired location Found
					print("LOCATION FOUND")
					showToast(message: "LOCATION FOUND \(newLocation)")
					locationHistory.append(CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude))
					stopLocationManager()
				}
			} else if distance < 1 {
				let timerInterval = newLocation.timestamp.timeIntervalSince(self.lastLocation!.timestamp)
				
				if timerInterval >= TIMEOUT_INTERVAL {
					//Force Stop
					stopLocationManager()
				}
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
	
	func stopLocationManager() {}
}
