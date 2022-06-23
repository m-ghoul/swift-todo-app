import UIKit
import Intents

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        donateAllIntents()
    }
    
    private func donateAllIntents() {
        let englishIntent = TaskTrackerIntent()
        englishIntent.suggestedInvocationPhrase = "Add New Task"
        let englishInteraction = INInteraction(intent: englishIntent, response: nil)
        englishInteraction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("English interaction donation failed: \(error.description)")
                } else {
                    print("English interaction donation successful")
                }
            }
        }
        
        let arabicIntent = TaskTrackerArabicIntent()
        arabicIntent.suggestedInvocationPhrase = "أضف مهمة جديدة"
        let arabicInteraction = INInteraction(intent: arabicIntent, response: nil)
        arabicInteraction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Arabic interaction donation failed: \(error.description)")
                } else {
                    print("Arabic interaction donation successful")
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
