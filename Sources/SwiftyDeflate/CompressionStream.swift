//
//  CompressionStream.swift
//
//
//  Created by Anton Stremovskyy on 22.09.2023.
//

import Foundation
import zlib

class CompressionStream {
    private static let c_version: UnsafePointer<Int8> = zlibVersion()
    static let version: String = String(cString: c_version)
    
    private var strm = z_stream()
    private var outputBuffer = [UInt8](repeating: 0, count: 5000)
    private var isInitialized: Bool = false
    var hasSpecialInitialization: Bool = false
    var compressionLevel: CInt = -1
    var windowBits: CInt = 15
    var isDeflating: Bool = true
    
    func write(_ bytes: [UInt8], flush: Bool) throws -> [UInt8] {
        if !isInitialized {
            try initializeStream()
            isInitialized = true
        }
        return try process(bytes, flush: flush)
    }
    
    private func process(_ bytes: [UInt8], flush: Bool) throws -> [UInt8] {
        var inputBytes = bytes
        var result = [UInt8]()
        var res: CInt
        
        strm.avail_in = CUnsignedInt(inputBytes.count)
        inputBytes.withUnsafeMutableBytes { bufferPointer in
            strm.next_in = bufferPointer.baseAddress?.assumingMemoryBound(to: UInt8.self)
        }
        
        repeat {
            strm.avail_out = CUnsignedInt(outputBuffer.count)
            outputBuffer.withUnsafeMutableBytes { bufferPointer in
                strm.next_out = bufferPointer.baseAddress?.assumingMemoryBound(to: UInt8.self)
            }
            
            if isDeflating {
                res = deflate(&strm, flush ? 1 : 0)
            } else {
                res = inflate(&strm, flush ? 1 : 0)
            }
            
            if res < 0 {
                try handleError(res)
            }
            
            let bytesProcessed = outputBuffer.count - Int(strm.avail_out)
            if bytesProcessed > 0 {
                result += outputBuffer[0..<bytesProcessed]
            }
            
        } while strm.avail_out == 0 && res != 1
        
        if strm.avail_in != 0 {
            throw DeflateError.undefined
        }
        
        return result
    }
    
    private func initializeStream() throws {
        var res: CInt
        if isDeflating {
            if hasSpecialInitialization {
                res = deflateInit2_(&strm, compressionLevel, 8, windowBits, 8, 0, CompressionStream.c_version, CInt(MemoryLayout<z_stream>.size))
            } else {
                res = deflateInit_(&strm, compressionLevel, CompressionStream.c_version, CInt(MemoryLayout<z_stream>.size))
            }
        } else {
            if hasSpecialInitialization {
                res = inflateInit2_(&strm, windowBits, CompressionStream.c_version, CInt(MemoryLayout<z_stream>.size))
            } else {
                res = inflateInit_(&strm, CompressionStream.c_version, CInt(MemoryLayout<z_stream>.size))
            }
        }
        if res != 0 {
            try handleError(res)
        }
    }
    
    private func handleError(_ errorCode: CInt) throws {
        switch errorCode {
            case 1:
                throw DeflateError.streamEnd
            case 2:
                throw DeflateError.needDict
            case -1:
                throw DeflateError.system
            case -2:
                throw DeflateError.stream
            case -3:
                throw DeflateError.data
            case -4:
                throw DeflateError.memory
            case -5:
                throw DeflateError.buffer
            case -6:
                throw DeflateError.version
            default:
                throw DeflateError.undefined
        }
    }
    
    deinit {
        if isInitialized {
            if isDeflating {
                deflateEnd(&strm)
            } else {
                inflateEnd(&strm)
            }
        }
    }
}
