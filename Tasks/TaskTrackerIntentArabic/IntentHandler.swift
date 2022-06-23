import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        guard intent is TaskTrackerArabicIntent else {
          fatalError("Unhandled Intent error : \(intent)")
        }
       return TaskTrackerArabicHandler()
    }
}

class TaskTrackerArabicHandler: NSObject, TaskTrackerArabicIntentHandling {
    func handle(intent: TaskTrackerArabicIntent, completion: @escaping (TaskTrackerArabicIntentResponse) -> Void) {
       if let title = intent.title {
           let listSize = addTask(title: title)
           completion(TaskTrackerArabicIntentResponse.success(numberOfTasks: NSNumber(value: listSize)))
       }
    }
    
    func resolveTitle(for intent: TaskTrackerArabicIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
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

