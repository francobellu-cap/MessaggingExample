import UIKit
import Firebase
import FirebaseInstanceID
@objc(ViewController)
class ViewController: UIViewController {
 
  @IBOutlet weak var pushMessage: UILabel!
  var fcmTokenMessage: String = ""
//  @IBOutlet weak var instanceIDTokenMessage: UILabel!

  override func viewDidLoad() {
    print("FB:", #function)
    NotificationCenter.default.addObserver(self, selector: #selector(self.displayFCMToken(notification:)),
                                           name: Notification.Name("FCMToken"), object: nil)
  }
    
  @IBAction func handleLogTokenTouch(_ sender: UIButton) {
    print("FB:", #function)
    let token = Messaging.messaging().fcmToken
    print("FCM token: \(token ?? "")")
    self.pushMessage.text  = "Logged FCM token: \(token ?? "")"

    Installations.installations().installationID{ (result, error) in
//    Installations.installationID{ (result, error) in
//    InstanceID.instanceID().instanceID { (result, error) in
      if let error = error {
        print("Error fetching remote instance ID: \(error)")
      } else if let result = result {
        print("Remote instance ID token: \(result)")
//        self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result)"
      }
    }
  }

//  @IBAction func handleSubscribeTouch(_ sender: UIButton) {
//    print("FB:", #function)
//    Messaging.messaging().subscribe(toTopic: "weather") { error in
//      print("Subscribed to weather topic")
//    }
//  }

  @objc func displayFCMToken(notification: NSNotification){
    print("FB:", #function)
    guard let userInfo = notification.userInfo else {return}
    if let fcmToken = userInfo["token"] as? String {
      self.fcmTokenMessage = "Received FCM token: \(fcmToken)"
    }
  }
}
