//
//  InflateStream.swift
//  
//
//  Created by Anton Stremovskyy on 22.09.2023.
//

import Foundation

class InflateStream: CompressionStream {
    override init() {
        super.init()
        isDeflating = false
    }
    
    convenience init(windowBits: Int) {
        self.init()
        self.hasSpecialInitialization = true
        self.windowBits = CInt(windowBits)
    }
}
