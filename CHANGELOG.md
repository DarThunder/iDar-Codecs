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

### v1.0.1-beta

#### Fixed

- **Installer script** now correctly downloads and installs all modules
- **Module require paths** fixed across all components
- **File structure** reorganized for proper dependency resolution
- **Cross-module imports** now work correctly (node, tree, context, etc.)
- **Installation process** streamlined and validated

#### Technical Details

- Fixed incorrect path mappings in module dependencies
- Resolved circular require issues
- Standardized all module paths to use consistent naming
- Verified installer can successfully deploy complete library

#### Impact

- **Before**: Installation failed with "module not found" errors (and install my Bignum lib lmao)
- **After**: Clean installation with all components working correctly
- Users can now successfully `require("idar-cod.huffman.init")` after installation

**Note**: Sometimes the most "obvious" issues (like file paths) are the ones that slip through! The library architecture was solid - just needed the plumbing connected properly.
