//
//  AppDelegate.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 27/12/22.
//

import UIKit
import IQKeyboardManager
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let manager = IQKeyboardManager.shared
        manager().isEnabled = true
        
        manager().toolbarDoneBarButtonItemText = "Hide"
        /// check for if user is already logged in then navigate to HomeVC if not then navigate to SigninVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           
           // if user is logged in before
        if UserDefaults.standard.bool(forKey: APP.IS_LOGIN) {
            let mainTabBarController = storyboard.instantiateViewController(identifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
            window?.rootViewController = mainTabBarController
            window?.makeKeyAndVisible()
        } else  {
            let loginNavController = storyboard.instantiateViewController(identifier: "SignInViewController")
            window?.rootViewController = loginNavController
            window?.makeKeyAndVisible()
        }
        
        FirebaseApp.configure()
        return true
    }

  
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       let firebaseAuth = Auth.auth()
       firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)

   }

   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
       let firebaseAuth = Auth.auth()
       if (firebaseAuth.canHandleNotification(userInfo)){
           print(userInfo)
           return
       }
   }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      if Auth.auth().canHandle(url) {
        return true
      }
      // URL not auth related; it should be handled separately.
        return true
    }


}

