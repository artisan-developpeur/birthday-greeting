//
//  AppDelegate.swift
//  Birthday Greeting
//
//  Created by Max on 27/04/2020.
//  Copyright © 2020 artisandeveloppeur. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    let navVC = UINavigationController(rootViewController: ViewController())
    window?.rootViewController = navVC
    window?.makeKeyAndVisible()
    
    return true
  }

}

