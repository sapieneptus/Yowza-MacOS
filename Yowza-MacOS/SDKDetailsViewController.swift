
import Cocoa
import HockeySDK

class SDKDetailsViewController: NSViewController {

    @IBOutlet var versionLabel: NSTextField!
    @IBOutlet var configDetails: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.stringValue = Config.appVersion()

        let config = Config.shared
        let configString = "Environment: \(config.environment)\nFeed URL: \(config.feedURL)"

        configDetails.stringValue = configString
        initializeSDK()
    }
    
    @IBAction func crashButtonClicked(_ sender: NSButton) {
        BITHockeyManager.shared()?.crashManager.generateTestCrash()
    }
    
    func initializeSDK() {
        let config = Config.shared

        BITHockeyManager.shared().configure(withIdentifier: config.appId)
        BITHockeyManager.shared().logLevel = BITLogLevel.verbose
        BITHockeyManager.shared().serverURL = config.environment.rawValue

        BITHockeyManager.shared().metricsManager.disabled = true
        
        BITHockeyManager.shared().start()
    }
}

