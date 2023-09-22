//
//  DeflateStream.swift
//  
//
//  Created by Anton Stremovskyy on 22.09.2023.
//

import Foundation

class DeflateStream: CompressionStream {
    convenience init(level: Int) {
        self.init()
        self.compressionLevel = CInt(level)
    }
    
    convenience init(windowBits: Int) {
        self.init()
        self.hasSpecialInitialization = true
        self.windowBits = CInt(windowBits)
    }
    
    convenience init(level: Int, windowBits: Int) {
        self.init()
        self.hasSpecialInitialization = true
        self.compressionLevel = CInt(level)
        self.windowBits = CInt(windowBits)
    }
}
