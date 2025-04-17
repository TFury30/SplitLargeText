#!/usr/bin/env python3

import os
import sys
import argparse

def parse_args():
    parser = argparse.ArgumentParser(
        description="Split a large text file into smaller chunks with optional duplicate removal."
    )
    parser.add_argument("-input", required=True, help="Path to the input large text file.")
    parser.add_argument("-LPF", type=int, default=100000, help="Lines per file. Default is 100000.")
    parser.add_argument("-output", required=True, help="Directory to save output files.")
    parser.add_argument("-removeDuplicates", action='store_true', help="Enable duplicate line removal.")
    return parser.parse_args()

def main():
    args = parse_args()

    input_path = args.input
    output_dir = args.output
    lines_per_file = args.LPF
    remove_duplicates = args.removeDuplicates

    # Validate input file
    if not os.path.isfile(input_path):
        print(f"❌ Error: Input file '{input_path}' not found.")
        sys.exit(1)

    # Create output folder if it doesn't exist
    if not os.path.isdir(output_dir):
        try:
            os.makedirs(output_dir)
            print(f"📁 Created output folder: {output_dir}")
        except Exception as e:
            print(f"❌ Error creating output folder: {e}")
            sys.exit(1)

    input_filename = os.path.splitext(os.path.basename(input_path))[0]
    seen_lines = set() if remove_duplicates else None
    file_index = 1
    line_counter = 0
    total_written = 0

    print(f"🔄 Splitting of '{input_filename}.txt' started. This might take a while...")

    try:
        with open(input_path, "r", encoding="utf-8", errors="ignore") as infile:
            output_file = os.path.join(output_dir, f"{input_filename}_Part{file_index}.txt")
            outfile = open(output_file, "w", encoding="utf-8")

            for line in infile:
                line = line.rstrip('\n')

                if remove_duplicates:
                    if line in seen_lines:
                        continue
                    seen_lines.add(line)

                outfile.write(line + "\n")
                line_counter += 1
                total_written += 1

                if line_counter >= lines_per_file:
                    outfile.close()
                    print(f"✅ Written {total_written} lines so far.")
                    file_index += 1
                    output_file = os.path.join(output_dir, f"{input_filename}_Part{file_index}.txt")
                    outfile = open(output_file, "w", encoding="utf-8")
                    line_counter = 0

            outfile.close()
        print(f"🎉 Done! The file was split into {file_index} parts.")
    except Exception as e:
        print(f"❌ Error during file processing: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
