//
//  DeflateError.swift
//  
//
//  Created by Anton Stremovskyy on 22.09.2023.
//

import Foundation

enum DeflateError: Error, CustomStringConvertible {
    case streamEnd
    case needDict
    case system
    case stream
    case data
    case memory
    case buffer
    case version
    case undefined
    
    var description: String {
        switch self {
            case .streamEnd:
                return "The compression stream has reached the end."
            case .needDict:
                return "The stream requires a dictionary for decompression."
            case .system:
                return "A system error occurred during compression or decompression."
            case .stream:
                return "A stream error occurred. The stream state might be inconsistent."
            case .data:
                return "The input data was corrupted or invalid."
            case .memory:
                return "Insufficient memory to process the stream."
            case .buffer:
                return "The buffer size was insufficient for the operation."
            case .version:
                return "The zlib version is incompatible or unsupported."
            case .undefined:
                return "An unknown error occurred during the operation."
        }
    }
}
