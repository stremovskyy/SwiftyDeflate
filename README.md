# SwiftyDeflate

A Swift package that offers simple compression (deflate) and decompression (inflate) functionalities built on top of zlib.

![Swift](https://img.shields.io/badge/Swift-5.3-orange.svg)
![Platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg)

## Features

- [x] Compression using `deflate`
- [x] Decompression using `inflate`
- [x] Customizable compression levels
- [x] Seamless integration with `Data` type in Swift

## Installation

### Swift Package Manager

Add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/stremovskyy/SwiftyDeflate.git", from: "1.0.0")
```

## Usage

### Deflate (Compression)

```swift
do {
    let originalData: Data = ... // Your data
    let compressedData = try originalData.deflateCompress()
    // Use compressedData
} catch {
    print("Error during compression: \(error.localizedDescription)")
}
```

### Inflate (Decompression)

```swift
do {
    let compressedData: Data = ... // Your compressed data
    let decompressedData = try compressedData.deflateDecompress()
    // Use decompressedData
} catch {
    print("Error during decompression: \(error.localizedDescription)")
}
```

## Requirements

- Swift 5.3+
- macOS, iOS, watchOS, tvOS

## Contributing

Contributions are very welcome! Please submit a pull request or create an issue to share your improvements or report bugs.

## License

SwiftyDeflate is released under the MIT License. See `LICENSE` for details.
