import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var task: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = task
    }
}
