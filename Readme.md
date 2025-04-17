---
# 📂 SplitLargeText

A high-performance script for **splitting very large text files** into smaller chunks — available in **PowerShell** and **Python**. Both versions offer optional **duplicate line removal**, efficient memory handling, and user-friendly progress output.

---

## 🔀 Versions Available

| Language     | Platform        | Filename               |
|--------------|------------------|------------------------|
| PowerShell   | Windows          | `SplitLargeText.ps1`   |
| Python       | Cross-platform   | `split_large_text.py`  |

---

## 🚀 Features (Shared)

- ✅ Splits huge text files by a configurable number of lines
- 🧹 Optional removal of **duplicate lines**
- 🔄 Real-time progress messages
- 🗂️ Output files named `<OriginalFileName>_Part1.txt`, `<OriginalFileName>_Part2.txt`, etc.
- 📁 Auto-creates output folders if they don’t exist
- 🛡️ Built-in error handling and help

---

## 📥 PowerShell Usage (Windows)

### 📜 Script: `SplitLargeText.ps1`

### ⚙️ Parameters

| Parameter             | Type      | Required | Description                                                  |
|------------------------|-----------|----------|--------------------------------------------------------------|
| `-input`              | `string`  | ✅ Yes   | Full path to the input `.txt` file                           |
| `-LPF`                | `int`     | ❌ No    | Lines per file (default is `100000`)                         |
| `-output`             | `string`  | ✅ Yes   | Output folder path                                           |
| `-removeDuplicates`   | `switch`  | ❌ No    | If set, removes duplicate lines before splitting             |

### 🧪 Example

```powershell
.\SplitLargeText.ps1 -input "C:\data\bigfile.txt" -LPF 50000 -output "C:\data\out"
```

With duplicate removal:

```powershell
.\SplitLargeText.ps1 -input "C:\data\bigfile.txt" -LPF 50000 -output "C:\data\out" -removeDuplicates
```

---

## 🐍 Python Usage (Linux/macOS/Windows)

### 📜 Script: `split_large_text.py`

### ⚙️ Parameters

| Flag                 | Required | Description                                                              |
|----------------------|----------|--------------------------------------------------------------------------|
| `-input`             | ✅ Yes   | Path to the input large text file                                        |
| `-LPF`               | ❌ No    | Lines per file (default: `100000`)                                       |
| `-output`            | ✅ Yes   | Directory to save output files                                           |
| `-removeDuplicates`  | ❌ No    | Optional flag to enable duplicate line removal                           |

### 🧪 Example

```bash
python3 split_large_text.py -input "/home/user/big.txt" -LPF 10000 -output "/home/user/output"
```

With duplicate removal:

```bash
python3 split_large_text.py -input "/home/user/big.txt" -LPF 10000 -output "/home/user/output" -removeDuplicates
```

---

## 📁 Output Format

Split files will be saved as:

```
<OriginalFileName>_Part1.txt
<OriginalFileName>_Part2.txt
<OriginalFileName>_Part3.txt
...
```

---

## 🔧 Under the Hood

- Both versions read the input file **line-by-line** for performance.
- Duplicate removal uses a **HashSet** (PowerShell) or `set()` (Python) for efficient filtering.
- After every `LPF` lines, a new output file is created.
- Files are encoded in UTF-8 for compatibility.

---

## 🧯 Error Handling

- Checks if input file exists
- Creates the output directory if missing
- Catches and reports I/O or permission errors
- Displays usage instructions if required parameters are missing

---

## 📦 Requirements

| Language     | Runtime               |
|--------------|------------------------|
| PowerShell   | PowerShell 5.1+ or Core |
| Python       | Python 3.6+             |

---

## 📜 License

MIT License — Free to use, modify, and distribute.

---

## 🙋 Support

Feel free to open issues or submit pull requests. Contributions are welcome!
```

---
