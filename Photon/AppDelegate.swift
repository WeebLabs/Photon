//
//  AppDelegate.swift
//  Photon
//
//  Created by Haru-tan on 06/01/2019.
//  Copyright © 2019 Haru-tan. All rights reserved.
//

import Cocoa
import EonilFSEvents

var firstRun = true

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        if firstRun == true {runProcess(); sleep(1); firstRun = false}

        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("icon10"))

            constructMenu()
            
            let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
            let homeString = homeDirURL.path
            try! EonilFSEvents.startWatching(
                paths: [homeString + "/Library/Application Support/Dock/"],
                for: ObjectIdentifier(self),
                with: { event in runProcess() })
        }
    }
    
    @objc func quitApp(_ sender: Any?) {
        sendingString = "000" + "000" + "000" + "\n"
        updateLEDs()
        NSApplication.shared.terminate(self)
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        //menu.addItem(NSMenuItem)
        //menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Photon", action: #selector(quitApp(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
}

