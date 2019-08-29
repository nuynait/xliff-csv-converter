//
//  FileManager.swift
//  xliff-csv
//
//  Created by Tianyun Shan on 2019-08-28.
//  Copyright © 2019 Tianyun Shan. All rights reserved.
//

import Foundation

class FileReader {
    /**
     Read file by path into line by line String.

     - Parameter path: Path to read
     - Returns: Array of strings, each index is a line in the file.
     */
    private static func readFile(path: String) -> [String] {
        let expandedPath = (path as NSString).expandingTildeInPath

        do {
            let content = try String(contentsOfFile: expandedPath, encoding: String.Encoding.utf8)
            let lines = content.components(separatedBy: .newlines)
            return lines
        } catch {
            print("Error, Cannot read file from path: \(expandedPath)")
            return []
        }
    }

    /**
     Read `.xliff` line by line and convert them to array of `Word` model

     - Parameter path: Path to read
     - Returns: Word model array
     */
    public static func readXliff(path: String) -> [Word] {
        let lines = readFile(path: path)
        var newWord = Word()
        var result: [Word] = []
        for line in lines {
            // Start a word, or stop a word
            if line.trim().starts(with: "<trans-unit") {
                newWord = Word()
            } else if line.trim().starts(with: "</trans-unit>") {
                result.append(newWord)
            }

            // Populate Word
            if let source = line.trim().tagContents(tag: "source") {
                newWord.source = source
            } else if let target = line.trim().tagContents(tag: "target") {
                newWord.target = target
            } else if let note = line.trim().tagContents(tag: "note") {
                newWord.note = note
            }
        }
        return result
    }

    /**
     Read `.csv` line by line and convert them to array of `Word` model

     - Parameter path: Path to read
     - Returns: Word model array
     */
    public static func readCsv(path: String) -> [Word] {
        var lines: [String] = readFile(path: path)
        var result: [Word] = []

        // Remove the first line
        lines.removeFirst()
        for line in lines {
            var newWord = Word()
            let tokens = line.components(separatedBy: "\t")
            newWord.source = tokens[0]
            newWord.target = tokens[1]
            newWord.note = tokens[2]
            result.append(newWord)
        }
        return result
    }
}
