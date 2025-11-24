# iDar-Codecs

iDar-Codecs is a high-performance compression library implementing Huffman coding and LZ77 algorithms optimized for ComputerCraft: Tweaked. Designed to reduce data storage requirements and transmission costs while maintaining full data integrity.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
  - [Huffman Compression](#huffman-compression)
  - [Advanced Usage](#advanced-usage)
- [API Reference](#api-reference)
- [Performance](#performance)
- [Security Notes](#security-notes)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Huffman Coding**: Optimal prefix codes for efficient compression
- **Multi-format Support**: Strings, tables, and numbers with automatic serialization
- **UTF-8 Compatible**: Full support for international characters
- **Context-based Architecture**: Unified state management for compression/decompression
- **Efficient Bit Packing**: Optimal byte-level compression
- **Compression Statistics**: Detailed metrics and performance ratios

## Requirements

- Minecraft with ComputerCraft: Tweaked mod installed
- Minecraft 1.20.1 or above
- Basic knowledge of Lua programming

## Installation

### Recommended Installation (via [`iDar-Pacman`](https://github.com/DarThunder/iDar-Pacman)):

```lua
pacman -S idar-codecs
```

### Manual Installation:

1. Download the library files from the repository
2. Place them in your ComputerCraft computer's directory (e.g directory/)
3. Use `require("directory.module")` to load specific modules

## Usage

### Huffman Compression

```lua
local Huffman = require("iDar.Codecs.src.huffman.init")

-- Basic string compression
local original_text = "The quick brown fox jumps over the lazy dog"
local state = Huffman.compress(original_text)

print("Compression ratio: " .. state.compression_ratio)
print("Original size: " .. state.original_size)
print("Compressed size: " .. state.compressed_size)

-- Decompression
local decompressed = Huffman.decompress(state)
print(decompressed) -- Output: The quick brown fox jumps over the lazy dog
```

### Advanced Usage

```lua
local Huffman = require("iDar.Codecs.src.huffman.init")

-- Compressing tables
local data_table = {
    name = "John Doe",
    age = 30,
    city = "London",
    tags = {"developer", "gamer", "reader"}
}
local state_table = Huffman.compress(data_table)
local restored_table = Huffman.decompress(state_table)

print(restored_table.name) -- Output: John Doe

-- Compressing numbers
local large_number = 3.141592653589793
local state_number = Huffman.compress(large_number)
local restored_number = Huffman.decompress(state_number)

print(restored_number) -- Output: 3.141592653589793
```

## API Reference

### `Huffman.compress(data)`

Compresses input data using Huffman coding.

**Parameters:**

- `data` (string|table|number): Data to compress

**Returns:**

- `state` (table): A unified state object containing all compressed data and statistics, required for decompression.

### `Huffman.decompress(state)`

Decompresses data that was compressed using Huffman coding.

**Parameters:**

- `state` (table): The state object returned by **`Huffman.compress()`** that contains the data and tables necessary for decoding.

**Returns:**

- `decompressed_data` (string|table|number): Original decompressed data

## Performance

### Compression Ratios

- **Text data**: 40-60% of original size
- **Structured data**: 30-50% of original size
- **Repetitive data**: 20-40% of original size

### Time Complexity

- **Tree Construction**: O(n log n)
- **Encoding/Decoding**: O(n)

### Memory Usage

- Efficient processing with minimal overhead
- Automatic garbage collection
- Stream-friendly architecture

## Security Notes

**Important Considerations:**

- This library provides **compression, not encryption**
- Compressed data may reveal frequency patterns from the original content
- For sensitive information, encrypt data before compression
- The library is designed for **ComputerCraft environments** and educational use

## FAQ

**Q: What types of data compress best?**
A: Text with repeated patterns, structured data with redundancy, and numerical data with limited value ranges compress most effectively.

**Q: Can I compress binary data?**
A: Yes, the library handles all byte values, making it suitable for binary data compression.

**Q: What's the maximum compression ratio I can expect?**
A: Depending on data redundancy, ratios of 20-60% are typical. Highly random data may see little compression.

**Q: Is the compression lossless?**
A: Yes, iDar-Codecs provides perfect lossless compression - decompressed data is identical to the original.

**Q: Can I use this for network transmission?**
A: Absolutely! The compressed format is ideal for reducing bandwidth usage in AxiomNet or other networking protocols.

## Contributing

We welcome contributions! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch for your changes
3. Ensure code follows existing style and includes documentation
4. Test your changes thoroughly
5. Submit a pull request with a clear description

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

**Upcoming Features**: LZ77 compression, hybrid compression modes, and dictionary-based optimization in future releases.
