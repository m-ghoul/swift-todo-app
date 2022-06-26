import UIKit
import IntentsUI

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSiriButtons(to: view)
    }
    
    func addSiriButtons(to view: UIView) {
        // English Single Parameter
        let englishLabel = UILabel()
        englishLabel.textAlignment = .left
        englishLabel.translatesAutoresizingMaskIntoConstraints = false
        englishLabel.text = "English"
        view.addSubview(englishLabel)
        englishLabel.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: +50).isActive = true
        englishLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: +200).isActive = true
        
        let englishButton = INUIAddVoiceShortcutButton(style: .automaticOutline)
        englishButton.shortcut = INShortcut(intent: englishIntent )
        englishButton.delegate = self
        englishButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(englishButton)
        englishButton.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        englishButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: +200).isActive = true
        
        // Arabic Single Parameter
        let arabicLabel = UILabel()
        arabicLabel.textAlignment = .left
        arabicLabel.text = "العربية"
        arabicLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arabicLabel)
        arabicLabel.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: +50).isActive = true
        arabicLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: +275).isActive = true
        
        let arabicButton = INUIAddVoiceShortcutButton(style: .automaticOutline)
        arabicButton.shortcut = INShortcut(intent: arabicIntent )
        arabicButton.delegate = self
        arabicButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arabicButton)
        arabicButton.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        arabicButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: +275).isActive = true
        
        // English Dual Parameter
        let englishWithIdLabel = UILabel()
        englishWithIdLabel.textAlignment = .left
        englishWithIdLabel.translatesAutoresizingMaskIntoConstraints = false
        englishWithIdLabel.text = "English"
        view.addSubview(englishWithIdLabel)
        englishWithIdLabel.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: +50).isActive = true
        englishWithIdLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: +400).isActive = true
        
        let englishWithIdButton = INUIAddVoiceShortcutButton(style: .automaticOutline)
        englishWithIdButton.shortcut = INShortcut(intent: englishIntentWithId )
        englishWithIdButton.delegate = self
        englishWithIdButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(englishWithIdButton)
        englishWithIdButton.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        englishWithIdButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: +400).isActive = true
        
        // Arabic Dual Parameter
        let arabicWithIdLabel = UILabel()
        arabicWithIdLabel.textAlignment = .left
        arabicWithIdLabel.translatesAutoresizingMaskIntoConstraints = false
        arabicWithIdLabel.text = "العربية"
        view.addSubview(arabicWithIdLabel)
        arabicWithIdLabel.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: +50).isActive = true
        arabicWithIdLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: +475).isActive = true
        
        let arabicWithIdButton = INUIAddVoiceShortcutButton(style: .automaticOutline)
        arabicWithIdButton.shortcut = INShortcut(intent: arabicIntentWithId )
        arabicWithIdButton.delegate = self
        arabicWithIdButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arabicWithIdButton)
        arabicWithIdButton.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -100).isActive = true
        arabicWithIdButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: +475).isActive = true
    }
}

extension SettingsViewController: INUIAddVoiceShortcutButtonDelegate {
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

extension SettingsViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController {
    public var englishIntent: TaskTrackerIntent {
        let englishIntent = TaskTrackerIntent()
        englishIntent.suggestedInvocationPhrase = "Add New Task"
        return englishIntent
    }
    
    public var arabicIntent: TaskTrackerArabicIntent {
        let arabicIntent = TaskTrackerArabicIntent()
        arabicIntent.suggestedInvocationPhrase = "أضف مهمة جديدة"
        return arabicIntent
    }
    
    public var englishIntentWithId: TaskTrackerWithIdIntent {
        let englishIntentWithId = TaskTrackerWithIdIntent()
        englishIntentWithId.suggestedInvocationPhrase = "Add New Task With ID"
        return englishIntentWithId
    }
    
    public var arabicIntentWithId: TaskTrackerWithIdArabicIntent {
        let arabicIntentWithId = TaskTrackerWithIdArabicIntent()
        arabicIntentWithId.suggestedInvocationPhrase = "إضافة مهمة جديدة بمعرف"
        return arabicIntentWithId
    }
}
