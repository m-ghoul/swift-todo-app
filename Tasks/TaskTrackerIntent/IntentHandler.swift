import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        guard intent is TaskTrackerIntent else {
          fatalError("Unhandled Intent error : \(intent)")
        }
       return TaskTrackerHandler()
    }
}

class TaskTrackerHandler: NSObject, TaskTrackerIntentHandling {
    func handle(intent: TaskTrackerIntent, completion: @escaping (TaskTrackerIntentResponse) -> Void) {
       if let title = intent.title {
           let listSize = addTask(title: title)
           completion(TaskTrackerIntentResponse.success(numberOfTasks: NSNumber(value: listSize)))
       }
    }
    
    func resolveTitle(for intent: TaskTrackerIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let title = intent.title else {
           completion(INStringResolutionResult.needsValue())
           return
        }
        completion(INStringResolutionResult.success(with: title))
    }
    
    func addTask(title: String) -> Int {
        var data = [[String:Any]]()
        data.append(["title": title])
        if let userDefaults = UserDefaults(suiteName: "group.org.qcri.Tasks") {
            if let taskData = userDefaults.array(forKey: "TaskData") as? [[String: Any]] {
                data.append(contentsOf: taskData)
                userDefaults.set(data, forKey: "TaskData")
                userDefaults.synchronize()
            } else {
                userDefaults.set(data, forKey: "TaskData")
                userDefaults.synchronize()
            }
        }
       return data.count
    }
}
