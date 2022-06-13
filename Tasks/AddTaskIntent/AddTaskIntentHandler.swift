//
//  AddTaskIntentHandler.swift
//  AddTaskIntent
//
//  Created by sweintern on 6/13/22.
//

import Foundation
import Intents
import UIKit

class AddTaskIntentHandler :  UIViewController, AddTaskIntentHandling {
    
    var update: (() -> Void)?
    
    func resolveTitle(for intent: AddTaskIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let title = intent.title else {
            completion(INStringResolutionResult.needsValue())
            return
        }
        completion(INStringResolutionResult.success(with: title))
    }
    
    func handle(intent: AddTaskIntent, completion: @escaping (AddTaskIntentResponse) -> Void) {
        addTask(title: intent.title!)
        completion(AddTaskIntentResponse.success(listType: "to-do"))
    }
    
    //implement this method to get the to-do list from UserDefaults, add to it, save it again to user defaults
    //and return its size
    func addTask(title: String?) -> Void {
        guard let text = title else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }
}
