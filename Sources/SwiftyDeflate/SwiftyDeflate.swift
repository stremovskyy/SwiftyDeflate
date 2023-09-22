//
//  SwiftyDeflate.swift
//
//
//  Created by Anton Stremovskyy on 22.09.2023.
//

import Foundation
import zlib

extension Data {
        // Decompression
    func deflateDecompress() throws -> Data {
        let inflater = InflateStream(windowBits: -15)
        let decompressedBytes = try inflater.write(Array(self), flush: true)
        return Data(decompressedBytes)
    }
    
        // Compression
    func deflateCompress(level: Int = Int(Z_DEFAULT_COMPRESSION)) throws -> Data {
        let deflater = DeflateStream(level: level, windowBits: -15)
        let compressedBytes = try deflater.write(Array(self), flush: true)
        return Data(compressedBytes)
    }
}

