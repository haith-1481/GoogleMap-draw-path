//
//  AccuracyLocation.swift
//  GoogleMapDemo
//
//  Created by Sean on 06/07/2023.
//

import Foundation
import CoreLocation
import GoogleMaps

extension ViewController: CLLocationManagerDelegate
{
	
	func setupCoreLocation() {
		locationManager.delegate = self
		locationManager.requestAlwaysAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
	}
	
	func startRequestLocation() {
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] _ in 
			// Request a user’s location once
			locationManager.requestLocation()
			
			if !doneInitialSetup, let location = locationHistory.last {
				let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 16.0)
				mapView = GMSMapView.map(withFrame: mapContainerView.frame, camera: camera)
				mapContainerView.addSubview(mapView!)
				doneInitialSetup = true
			}
			

			switch currentSegment {
			case 0:
				drawPolyline(mockPath: locationHistory)
			case 1:
				drawpath(positions: locationHistory)
			case 2:
					drawPlaceMark(location: locationHistory)
			default:
				return
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let TIMEOUT_INTERVAL = 3.0
//		centerMapOnLocation(location: locations.last!)
		let newLocation = locations.last as! CLLocation
		locationHistory.append(CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude))
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
