import Foundation
import Intents
import UIKit

class AddTaskIntentHandler :  NSObject, AddTaskIntentHandling {
    
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
        
//        update?()
//        
//        navigationController?.popViewController(animated: true)
    }
}
