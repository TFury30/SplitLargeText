---

# 📄 SplitLargeText.ps1

A high-performance PowerShell script to **split very large text files** into smaller, manageable chunks — with optional **duplicate line removal**.

---

## ⚙️ Features

- ✅ Efficient and fast line-by-line processing using `StreamReader` and `StreamWriter`
- 📂 Automatically splits any large `.txt` file into smaller files based on a given line limit
- 🧹 Optional removal of **duplicate lines**
- 📈 Real-time feedback on progress
- 📁 Automatically creates the output directory if it doesn't exist
- 🛠️ Built-in help screen when no parameters are provided

---

## 📥 Usage

```powershell
.\SplitLargeText.ps1 -input "C:\Path\to\largeFile.txt" -LPF 10000 -output "C:\Path\to\outputFolder"
```

---

## 📌 Parameters

| Parameter            | Type     | Required | Description                                                                 |
|----------------------|----------|----------|-----------------------------------------------------------------------------|
| `-input`             | `string` | ✅ Yes    | Full path to the input large text file.                                    |
| `-LPF`               | `int`    | ❌ No     | Lines per file (defaults to `100000` if not provided).                     |
| `-output`            | `string` | ✅ Yes    | Folder path where split files will be saved. Will be created if missing.  |
| `-removeDuplicates`  | `switch` | ❌ No     | If set, duplicate lines will be removed during the split.                  |

---

## 🧪 Examples

Split a file into 10,000-line chunks:

```powershell
.\SplitLargeText.ps1 -input "C:\data\bigfile.txt" -LPF 10000 -output "C:\data\output"
```

Split a file and remove duplicate lines:

```powershell
.\SplitLargeText.ps1 -input "C:\data\bigfile.txt" -LPF 50000 -output "C:\data\output" -removeDuplicates
```

---

## 🗂️ Output

Each chunked file will be saved in the output folder as:

```
<OriginalFileName>_Part1.txt
<OriginalFileName>_Part2.txt
...
```

For example, splitting `bigfile.txt` creates:
```
bigfile_Part1.txt
bigfile_Part2.txt
bigfile_Part3.txt
...
```

---

## 🔄 What Happens Internally

1. The script checks if all required parameters are provided.
2. If not, it shows a usage/help page and exits.
3. It validates the input file and creates the output directory if needed.
4. It opens the input file using a fast streaming reader.
5. For every line:
   - Writes it to the current output file.
   - If `-removeDuplicates` is specified, it uses a `HashSet<string>` to filter.
   - If the max line limit (`LPF`) is hit, it starts a new output file.
6. Progress is printed after each split point.
7. Files are saved with incremental names like `_Part1`, `_Part2`, etc.

---

## ✅ Requirements

- PowerShell 5.1 or later (Windows PowerShell or PowerShell Core)
- Works on Windows, Linux, or macOS (as long as PowerShell is available)

---

## 🧯 Error Handling

- ❌ If the input file doesn't exist, a red error message is shown and the script exits.
- 📁 If the output folder doesn't exist, it is created automatically.
- If any I/O issue occurs (e.g., write permission denied), a descriptive error is printed.

---

## 🙋 Help Screen

If the script is run without required parameters, it displays a friendly help message:

```powershell
.\SplitLargeText.ps1
```

---

## 🚀 Performance Tips

- Prefer local SSDs over network shares for best performance.
- If you don't need duplicate removal, skip `-removeDuplicates` — it's a bit slower.
- Use larger `-LPF` values for fewer, bigger files (less file I/O overhead).

---
