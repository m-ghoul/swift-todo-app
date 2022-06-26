import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        guard intent is TaskTrackerWithIdArabicIntent else {
          fatalError("Unhandled Intent error : \(intent)")
        }
       return TaskTrackerWithIdArabicHandler()
    }
}

class TaskTrackerWithIdArabicHandler: NSObject, TaskTrackerWithIdArabicIntentHandling {
    func handle(intent: TaskTrackerWithIdArabicIntent, completion: @escaping (TaskTrackerWithIdArabicIntentResponse) -> Void) {
        if let title = intent.title, let id = intent.id {
            let listSize = addTask(title: title, id: Int(truncating: id))
            completion(TaskTrackerWithIdArabicIntentResponse.success(numberOfTasks: NSNumber(value: listSize)))
       }
    }
    
    func resolveTitle(for intent: TaskTrackerWithIdArabicIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let title = intent.title else {
           completion(INStringResolutionResult.needsValue())
           return
        }
        completion(INStringResolutionResult.success(with: title))
    }
    
    func resolveId(for intent: TaskTrackerWithIdArabicIntent, with completion: @escaping (TaskTrackerWithIdArabicIdResolutionResult) -> Void) {
        guard let id = intent.id else {
           completion(TaskTrackerWithIdArabicIdResolutionResult.needsValue())
           return
        }
        completion(TaskTrackerWithIdArabicIdResolutionResult.success(with: Int(truncating: id)))
    }
    
    func addTask(title: String, id: Int) -> Int {
        var data = [[String:Any]]()
        data.append(["title": "\(id). \(title)"])
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
