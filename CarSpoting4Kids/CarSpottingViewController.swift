import UIKit

class CarSpottingViewController: UIViewController {

    
    // Instantiate the MultipeerConnectivity service manager
    let carSpottingService = tbgServiceManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        carSpottingService.delegate = self
    }
    
    @IBOutlet weak var connectionsLabel: UILabel!

    @IBAction func redTapped() {
        self.change(color: .red)
        carSpottingService.send(colorName: "red")
    }

    @IBAction func yellowTapped() {
        self.change(color: .yellow)
        carSpottingService.send(colorName: "yellow")
    }

    // MARK: - Functions
    
    // Function to change the background colour on the test app
    func change(color : UIColor) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = color
        }
    }
    
}

// Extension to handle the data from the connectivity service
extension CarSpottingViewController : tbgServiceManagerDelegate {

    func connectedDevicesChanged(manager: tbgServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }

    func colorChanged(manager: tbgServiceManager, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                self.change(color: .red)
            case "yellow":
                self.change(color: .yellow)
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }

}
