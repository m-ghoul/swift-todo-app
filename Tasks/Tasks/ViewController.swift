import UIKit
import IntentsUI

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tasks: [[String: Any]] = []
    let userDefaults = UserDefaults(suiteName: "group.org.qcri.Tasks")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks".localized()
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        addSiriButtons(to: view)
    }
    
    func addSiriButtons(to view: UIView) {
        let englishLabel = UILabel()
        englishLabel.textAlignment = .center
        englishLabel.translatesAutoresizingMaskIntoConstraints = false
        englishLabel.text = "English"
        view.addSubview(englishLabel)
        englishLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -85).isActive = true
        englishLabel.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -125).isActive = true
        
        let englishButton = INUIAddVoiceShortcutButton(style: .automaticOutline)
        englishButton.shortcut = INShortcut(intent: englishIntent )
        englishButton.delegate = self
        englishButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(englishButton)
        englishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -85).isActive = true
        englishButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -75).isActive = true
        
        let arabicLabel = UILabel()
        arabicLabel.textAlignment = .center
        arabicLabel.text = "العربية"
        arabicLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arabicLabel)
        arabicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: +85).isActive = true
        arabicLabel.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -125).isActive = true
        
        let arabicButton = INUIAddVoiceShortcutButton(style: .automaticOutline)
        arabicButton.shortcut = INShortcut(intent: arabicIntent )
        arabicButton.delegate = self
        arabicButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arabicButton)
        arabicButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: +85).isActive = true
        arabicButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -75).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.title = "Tasks".localized()
        tableView.delegate = self
        tableView.dataSource = self
        
        if let taskList = userDefaults.array(forKey: "TaskData") as? [[String: Any]] {
            self.tasks = taskList
            self.tableView.reloadData()
        }
        
        addSiriButtons(to: view)
    }
    
    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task".localized()
        vc.completion = { success in
            if let taskList = self.userDefaults.array(forKey: "TaskData") as? [[String: Any]] {
                self.tasks = taskList
                self.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task["title"] as? String
        return cell
    }
}

extension ViewController: INUIAddVoiceShortcutButtonDelegate {
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

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: INUIEditVoiceShortcutViewControllerDelegate {
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

extension ViewController {
    public var englishIntent: TaskTrackerWithIdIntent {
        let englishIntent = TaskTrackerWithIdIntent()
        englishIntent.suggestedInvocationPhrase = "Add New Task With Id"
        return englishIntent
    }
    
    public var arabicIntent: TaskTrackerArabicIntent {
        let arabicIntent = TaskTrackerArabicIntent()
        arabicIntent.suggestedInvocationPhrase = "أضف مهمة جديدة"
        return arabicIntent
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
