# Changelog

## Beta

### v1.0.0-beta

#### Added

- **Initial Huffman compression algorithm implementation**
- **Public API** with `Huffman.compress` and `Huffman.decompress` methods
- **Context-based architecture** for unified state management
- **Multi-format support** for strings, tables, and numbers with automatic serialization
- **UTF-8 character support** for international text compression
- **Efficient tree construction** using MinHeap priority queue for optimal performance
- **Bit stream compression** with proper padding handling
- **Compression statistics** including size metrics and ratio calculations

#### Technical Features

- **Modular design** with separated components (context, frequency analysis, tree building, code generation, bitstream)
- **Memory-efficient processing** with chunk-based operations
- **Automatic type detection** and restoration during decompression
- **Comprehensive error handling** for invalid inputs and edge cases

#### Performance

- **O(n log n)** time complexity for tree construction
- **O(n)** time complexity for encoding/decoding operations
- **Optimal prefix codes** generation using frequency analysis
