//
//  InterfaceController.swift
//  WatchAppSample WatchKit Extension
//
//  Created by iMac on 2022/10/12.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var label: WKInterfaceLabel!
    let session = WCSession.default
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        session.delegate = self
        session.activate()
    }
    
    override func willActivate() {
        super.willActivate()
        print("WillActive")
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        print("DidDeactivate")
    }
    
    
    @IBAction func onClickReset() {
        print("onClickReset is tapped")
        label.setText("Label")
    }
    
    
    @IBAction func tapSendToiPhone() {
        print("tapSendToiPhone is tapped")
        let data: [String: Any] = ["watch": "data from watch" as Any]
        session.transferUserInfo(data)
    }
    

}

extension InterfaceController: WCSessionDelegate {
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {
        print("ActivationDidCompleteWith")
    }
    
    func session(
        _ session: WCSession,
        didReceiveUserInfo userInfo: [String : Any] = [:]
    ) {
        print("received data: \(userInfo)")
        if let value = userInfo["iPhone"] as? String  {
            DispatchQueue.main.async {
                self.label.setText(value)
            }
        }
    }
    
}
