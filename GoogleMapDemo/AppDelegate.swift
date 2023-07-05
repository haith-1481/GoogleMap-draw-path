//
//  AppDelegate.swift
//  GoogleMapDemo
//
//  Created by Sean on 03/07/2023.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		setupGoogleMap()
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
	
	func setupGoogleMap() {
		let API_key = "AIzaSyBxbwTpYpm_onXhGYpmqFAnwBxBPomX9Yw"
		GMSServices.provideAPIKey(API_key)
		// Metal rendering framework
		GMSServices.setMetalRendererEnabled(true)
		// Place API 
//		GMSPlacesClient.provideAPIKey("YOUR_API_KEY")
	}
}

