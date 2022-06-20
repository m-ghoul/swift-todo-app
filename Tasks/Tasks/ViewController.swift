import UIKit
import IntentsUI

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    var tasks: [[String: Any]] = []
    let userDefaults = UserDefaults(suiteName: "group.org.qcri.Tasks")!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self

        if let taskList = userDefaults.array(forKey: "TaskData") as? [[String: Any]] {
            self.tasks = taskList
            self.tableView.reloadData()
        }
    }
    
    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
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
