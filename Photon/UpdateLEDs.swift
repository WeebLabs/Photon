//
//  UpdateLEDs.swift
//  Photon
//
//  Created by Haru-tan on 11/01/2019.
//  Copyright © 2019 Haru-tan. All rights reserved.
//

import Foundation
import ORSSerial

func updateLEDs() {
    let someData = sendingString.data(using: String.Encoding.utf8)!
    let serialPort = ORSSerialPort(path: "/dev/cu.usbmodem14101")!
    serialPort.baudRate = 9600
    serialPort.open()
    serialPort.send(someData) // someData is an NSData object
    //serialPort.close()
}
