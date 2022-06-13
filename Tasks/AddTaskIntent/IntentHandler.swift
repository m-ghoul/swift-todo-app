//
//  IntentHandler.swift
//  AddTaskIntent
//
//  Created by sweintern on 6/13/22.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is AddTaskIntent else {
          fatalError("Unhandled Intent error : \(intent)")
        }
       return AddTaskIntentHandler()
    }
}
