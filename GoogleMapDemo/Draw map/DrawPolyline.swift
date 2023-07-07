//
//  DrawPolyline.swift
//  GoogleMapDemo
//
//  Created by Sean on 05/07/2023.
//

import Foundation
import GoogleMaps

extension ViewController {
	func drawPolyline(mockPath: [CLLocationCoordinate2D]) {
		
		mapView?.clear()
		
		var path = GMSMutablePath()
		for location in mockPath {
			path.addLatitude(location.latitude, longitude: location.longitude)
		}
		path = path.pathOffset(byLatitude: -30, longitude: 0)
		pathLength = path.length(of: .geodesic) / 21
		for i in 0..<30 {
			let polyline = GMSPolyline(path: path.pathOffset(byLatitude: Double(i) * 1.5, longitude: 0))
			polyline.strokeWidth = 8
			polyline.geodesic = true
			polyline.map = mapView
			polylines.append(polyline)
		}
	}
}
