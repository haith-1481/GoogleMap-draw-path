//
//  AppleMapView.swift
//  GoogleMapDemo
//
//  Created by Sean on 07/07/2023.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
	
	func setupAppleMapView() {
		centerMapOnLocation(location: CLLocation(latitude: 21.00482361, longitude: 105.80686335))
	}
	
	func centerMapOnLocation(location: CLLocation) {
		let regionRadius: CLLocationDistance = 0.1
		let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		appleMapView.setRegion(coordinateRegion, animated: true)
	}
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
		renderer.strokeColor = UIColor.red
		renderer.lineWidth = 3
		return renderer
	}
	
	func drawPlaceMark(location: [CLLocationCoordinate2D]) {
		
		for sourceLocation in location {
			
			let destinationPlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
			
			let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
			
			let sourceAnnotation = MKPointAnnotation()
			sourceAnnotation.title = placeAnnotation?[indexPoint]
			
			indexPoint = indexPoint + 1
			
			if let location = destinationPlacemark.location {
				sourceAnnotation.coordinate = location.coordinate
			}
			self.appleMapView.showAnnotations([sourceAnnotation,sourceAnnotation], animated: true )
			
			
			// Calculate the direction and draw line
			let directionRequest = MKDirections.Request()
			directionRequest.source = destinationMapItem
			
			directionRequest.destination = destinationMapItem
			directionRequest.transportType = .walking
			
			let directions = MKDirections(request: directionRequest)
			
			directions.calculate {
				(response, error) -> Void in
				
				guard let response = response else {
					if let error = error {
						print("Error: \(error)")
					}
					return
				}
				
				let route = response.routes[0]
				self.appleMapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
				
				let rect = route.polyline.boundingMapRect
//				self.appleMapView.setRegion(MKCoordinateRegion(rect), animated: true)
			}
		}
	}
}
