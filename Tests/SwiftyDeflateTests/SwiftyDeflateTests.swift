import XCTest
@testable import SwiftyDeflate

final class DataExtensionTests: XCTestCase {
    
    func testDeflateDecompress() {
            // 1. Given
        let originalString = "This is a sample string for testing compression and decompression."
        let originalData = originalString.data(using: .utf8)!
        
            // 2. When
        do {
            let compressedData = try originalData.deflateCompress()
            
            XCTAssertNotEqual(originalData, compressedData, "Original data and compressed data should not be equal.")
            
            let decompressedData = try compressedData.deflateDecompress()
            let decompressedString = String(data: decompressedData, encoding: .utf8)
            
                // 3. Then
            XCTAssertEqual(originalString, decompressedString, "Original and decompressed strings should be the same.")
        } catch {
            XCTFail("Error during compression or decompression: \(error)")
        }
    }
    
    static var allTests = [
        ("testDeflateDecompress", testDeflateDecompress),
    ]
}
