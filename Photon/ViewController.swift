//
//  ViewController.swift
//  Photon
//
//  Created by Haru-tan on 06/01/2019.
//  Copyright © 2019 Haru-tan. All rights reserved.
//  This file is inactive. Used for testing new functionality.

import Cocoa
import Witness
import EonilFSEvents
import ORSSerial
import CocoaMQTT

class ViewController: NSViewController {
    
    let mqttClient = CocoaMQTT(clientID:"macOS Device", host: "raspberrypi", port: 1883) //Initialize CocoaMQTT
    
    @IBOutlet var receivedDataTextView: NSTextView!
    @IBOutlet weak var label1: NSTextField!
    
    @IBOutlet weak var button1: NSButton!
    //@IBOutlet weak var button1: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
        let homeString = homeDirURL.path
        try! EonilFSEvents.startWatching(
            paths: [homeString + "/Library/Application Support/Dock/"],
            for: ObjectIdentifier(self),
            with: { event in self.runProcess() })
        }
    
    
    @IBAction func connectButton(_ sender: NSButton) {
        if sender.state == .on {
            mqttClient.connect()
            button1.title = "Disconnect"
            mqttClient.publish("PhotonTest", withString: "Connected and working! El Psy Congroo.")
            
        }
        
        else {
            mqttClient.publish("PhotonTest", withString: "Disconnecting now!")
            mqttClient.disconnect()
            button1.title = "Connect"
        }
    }
 
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    func runProcess() {
        getColor()
        updateLEDs()
        
        
    }
    

}


