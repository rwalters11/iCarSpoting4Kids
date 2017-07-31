import UIKit

class CarSpottingViewController: UIViewController {

    @IBOutlet weak var connectionsLabel: UILabel!

    let carSpottingService = tbgServiceManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        carSpottingService.delegate = self
    }

    @IBAction func redTapped() {
        self.change(color: .red)
        carSpottingService.send(colorName: "red")
    }

    @IBAction func yellowTapped() {
        self.change(color: .yellow)
        carSpottingService.send(colorName: "yellow")
    }

    func change(color : UIColor) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = color
        }
    }
    
}

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
