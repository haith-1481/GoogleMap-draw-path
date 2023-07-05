//
//  Models.swift
//  GoogleMapDemo
//
//  Created by Sean on 03/07/2023.
//

import Foundation
import Alamofire

struct RoutesResult: Codable {
	var routes: [RouteData]
	
	enum CodingKeys: String, CodingKey {
		case routes = "routes"
	}
}

struct RouteData: Codable {
	var polyline: Polyline
	
	enum CodingKeys: String, CodingKey {
		case polyline = "overview_polyline"
	}
}

struct Polyline: Codable {
	var points: String
	
	enum CodingKeys: String, CodingKey {
		case points = "points"
	}
}
