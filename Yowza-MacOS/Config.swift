
import Foundation
import HockeySDK

class Config: NSObject {
    static let shared = try! Config()
    enum Environment : String {
        case Training = "https://training.hockeyapp.net/"
        case Rink = "https://rink.hockeyapp.net/"
    }

    let environment: Environment
    let appId: String
    let feedURL: String

    enum ConfigError: Error {
        case MissingValue(_ value: String)
    }

    init(_: Void?=nil) throws {
        let haEnv = Bundle.main.infoDictionary?["HA_ENV"] as! String
        if haEnv == "training" {
            self.environment = Environment.Training
        } else if  haEnv == "rink" {
            self.environment = Environment.Rink
        } else {
            throw ConfigError.MissingValue("HA_ENV")
        }

        guard let haAppId = Bundle.main.infoDictionary?["HA_APP_ID"] as? String else {
            throw ConfigError.MissingValue("HA_APP_ID")
        }
        self.appId = haAppId

        guard let feedURL = Bundle.main.infoDictionary?["SUFeedURL"] as? String else {
            throw ConfigError.MissingValue("SUFeedURL")
        }
        self.feedURL = feedURL
    }

    static func appVersion() -> String {
        let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let bundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        return "Version: \(shortVersion) (\(bundleVersion))"
    }
}
