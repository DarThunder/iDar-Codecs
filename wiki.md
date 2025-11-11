# Huffman Compression Module Wiki

## Introduction

This module implements Huffman coding compression algorithm for efficient data compression in ComputerCraft. It supports compression of strings, tables, and numbers with automatic serialization.

## Installation

```lua
local Huffman = require("idar-cod.huffman.init")
```

## Core Functions

### `Huffman.compress(data)`

Compresses input data using Huffman coding algorithm.

#### Parameters

- `data` (string|table|number): Data to compress. Tables and numbers are automatically serialized.

#### Returns

- `state` (table): A unified state object containing all compressed data and statistics, required for decompression.

#### Implementation Details

- Uses frequency analysis to build optimal prefix codes.
- Automatically handles **UTF-8** characters.
- Implements efficient bit packing into bytes.
- Returns a state object that includes:
  - **`compressed_bytes`** (string): The compressed data.
  - **`encoding_table`** (table): The code table used for compression.
  - **`total_bits`** (number): The exact number of compressed bits.
  - **`original_type`** (string): The original data type ("string", "table", "number").
  - **`original_size`**, **`compressed_size`**, **`compression_ratio`**: Performance statistics.

#### Example

```lua
local Huffman = require("idar-cod.init")

-- compress a string (return a unified state)
local text = "hello world"
local state_string = Huffman.compress(text)
print("Compression ratio: " .. state_string.compression_ratio)

-- compress a table (return a unified state)
local data = {name = "John", age = 30, city = "London"}
local state_table = Huffman.compress(data)

-- compress a number (return a unified state)
local number = 42
local state_number = Huffman.compress(number)
```

### `Huffman.decompress(state)`

Decompresses data that was compressed using Huffman coding.

#### Parameters

- `state` (table): The state object returned by **`Huffman.compress()`** that contains the data and tables necessary for decoding.

#### Returns

- `decompressed_data` (string|table|number): The original decompressed data.

#### Implementation Details

- Reconstructs the bit stream from `state.compressed_bytes`.
- Uses `state.encoding_table` for decoding.
- **Restores the original data type** (string, table, or number) automatically using `state.original_type`.
- Automatically handles padding bits.

#### Example

```lua
local Huffman = require("idar-cod.init")

-- Decompress (using the load state)
local decompressed_string = Huffman.decompress(state_string)
print(decompressed_string) -- "hello world"

local original_table = Huffman.decompress(state_table)
print(original_table.name) -- "John"

local original_number = Huffman.decompress(state_number)
print(original_number) -- 42
```

## Advanced Usage

### Working with Context

For advanced control over the compression process, you can use the context directly:

```lua
local Huffman = require("idar-cod.init")

-- Create context for manual processing
local ctx = Huffman.createContext("sample text")

-- Access compression statistics
local stats = ctx:getStats()
print("Original size: " .. stats.original_size)
print("Compressed size: " .. stats.compressed_size)
```

## Technical Details

### Algorithm Overview

1.  **Frequency Analysis**: Counts character frequencies in input data
2.  **Tree Building**: Constructs Huffman tree using min-heap priority queue
3.  **Code Generation**: Generates optimal prefix codes for each character
4.  **Bit Packing**: Encodes data using variable-length codes and packs into bytes

### Data Type Support

- **Strings**: Direct compression of text data
- **Tables**: Automatic serialization to string format
- **Numbers**: Converted to string representation

### Character Encoding

- Fully supports UTF-8 characters
- Handles multi-byte Unicode characters correctly
- Frequency analysis works on complete code points

## Performance Considerations

- **Memory Efficient**: Processes data in chunks where possible
- **Time Complexity**: O(n log n) for tree building, O(n) for encoding/decoding
- **Space Complexity**: Additional memory for frequency tables and encoding trees

## Error Handling

- Validates input parameters
- Provides clear error messages for missing encoding table entries
- Handles edge cases like empty input or single-character strings

## Example Workflow

```lua
local Huffman = require("idar-cod.init")

-- Complete compression/decompression cycle
local original_data = "The quick brown fox jumps over the lazy dog"

-- Compress (solo se devuelve una tabla de estado)
local state = Huffman.compress(original_data)
print("Compressed to " .. state.compression_ratio * 100 .. "% of original size")

-- Decompress (solo se recibe la tabla de estado)
local decompressed = Huffman.decompress(state)

-- Verify
print("Data matches: " .. tostring(original_data == decompressed))
```

## Security Notes

- This implementation is designed for data compression, not encryption
- Compression can reveal frequency patterns in the original data
- For sensitive information, consider encrypting before compression

This module provides efficient lossless compression suitable for reducing storage requirements and transmission costs in ComputerCraft applications.
