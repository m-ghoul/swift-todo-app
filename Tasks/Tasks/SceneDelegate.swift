//
//  SceneDelegate.swift
//  Tasks
//
//  Created by sweintern on 6/13/22.
//

import UIKit
import Intents

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        donateIntent()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func donateIntent(){
        let intent = AddTaskIntent
        intent.suggestedInvocationPhrase = "Add a new task"
        let interaction = INInteraction(intent: intent, response: nil)
            
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error.description)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }

}

