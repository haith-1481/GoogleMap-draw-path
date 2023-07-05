//
//  RequestPolyline.swift
//  GoogleMapDemo
//
//  Created by Sean on 05/07/2023.
//

import Foundation
import GoogleMaps
import Alamofire

extension ViewController {
	enum transitionMode: String {
		case walking
		case driving
		case bicycling
		case transit
	}
	
	func drawpath(positions: [CLLocationCoordinate2D]) {
		guard positions.count > 1 else { return }
		
		mapView?.clear()
		
		let constants = Constants()
		
		let origin = positions.first!
		let destination = positions.last!
		var wayPoints = ""
		for point in positions {
			wayPoints = wayPoints.count == 0 ? "\(point.latitude),\(point.longitude)" : "\(wayPoints)%7C\(point.latitude),\(point.longitude)"
		}
		
		let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin.latitude),\(origin.longitude)&destination=\(destination.latitude),\(destination.longitude)&mode=walking&waypoints=\(wayPoints)&key=\(constants.API_key2)"
		AF.request(url).responseDecodable(of: RoutesResult.self) { response in
			switch response.result {
			case .success(let data):
				let route: RoutesResult = data
				
				let path = GMSPath.init(fromEncodedPath: route.routes.first?.polyline.points ?? "")
				let polyline = GMSPolyline.init(path: path)
				polyline.strokeWidth = 4
				polyline.strokeColor = UIColor.red
				polyline.map = self.mapView
				
			case .failure(let error):
				// Error handle
				print(error)
			}
		}
	}
	
	func decodeDataToObject<T: Codable>(data : Data?)->T?{
		
		if let dt = data{
			do{
				
				return try JSONDecoder().decode(T.self, from: dt) 
				
			}  catch let DecodingError.dataCorrupted(context) {
				print(context)
			} catch let DecodingError.keyNotFound(key, context) {
				print("Key '\(key)' not found:", context.debugDescription)
				print("codingPath:", context.codingPath)
			} catch let DecodingError.valueNotFound(value, context) {
				print("Value '\(value)' not found:", context.debugDescription)
				print("codingPath:", context.codingPath)
			} catch let DecodingError.typeMismatch(type, context)  {
				print("Type '\(type)' mismatch:", context.debugDescription)
				print("codingPath:", context.codingPath)
			} catch {
				print("error: ", error)
			}
		}
		
		return nil
	}
}
