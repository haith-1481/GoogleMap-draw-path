//
//  ViewController.swift
//  GoogleMapDemo
//
//  Created by Sean on 03/07/2023.
//

import Foundation
import UIKit
import GoogleMaps

class ViewController: UIViewController {

	@IBOutlet weak var mapContainerView: UIView!
	
	@IBOutlet weak var polylineOptionSegment: UISegmentedControl!
	
	var mapView: GMSMapView?
	
	let mockPath: [CLLocationCoordinate2D] = [
		CLLocationCoordinate2D(latitude: 21.027959, longitude: 105.853688),
		CLLocationCoordinate2D(latitude: 21.027682, longitude: 105.854949),
		CLLocationCoordinate2D(latitude: 21.027460, longitude: 105.855892),
		CLLocationCoordinate2D(latitude: 21.027114, longitude: 105.854966),
		CLLocationCoordinate2D(latitude: 21.027248, longitude: 105.853780),
	]
	
	var pathLength: Double = 0
	var pos: Double = 0
	var polylines: [GMSPolyline] = []
	lazy var styles: [GMSStrokeStyle] = {
		let greenStyle = GMSStrokeStyle.gradient(from: .green, to: UIColor.green.withAlphaComponent(0))
		let redStyle = GMSStrokeStyle.gradient(from: UIColor.red.withAlphaComponent(0), to: .red)
		return [greenStyle, redStyle, GMSStrokeStyle.solidColor(UIColor(white: 0, alpha: 0))]
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupMap()
	}
	
	@IBAction func indexChanged(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex
		{
		case 0:
			drawPolyline(mockPath: mockPath)
		case 1:
			drawpath(positions: mockPath)
		default:
			break; 
		}
	}

}

extension ViewController {
	
	func createMarker() {
		// Creates a marker in the center of the map.
		let marker = GMSMarker()
		// 
		marker.position = CLLocationCoordinate2D(latitude: 21.027959, longitude: 105.853688)
		marker.title = "Hanoi"
		marker.snippet = "VietNam"
		marker.map = mapView
	}
	
	func setupMap() {
		// Do any additional setup after loading the view.
		// Create a GMSCameraPosition that tells the map to display the
		// coordinate -33.86,151.20 at zoom level 6.
		let camera = GMSCameraPosition.camera(withLatitude: 21.027959, longitude: 105.853688, zoom: 16.0)
		mapView = GMSMapView.map(withFrame: mapContainerView.frame, camera: camera)
		mapContainerView.addSubview(mapView!)
		
		drawPolyline(mockPath: mockPath)
	}
}
