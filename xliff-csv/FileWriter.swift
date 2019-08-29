//
//  FileWriter.swift
//  xliff-csv
//
//  Created by Tianyun Shan on 2019-08-28.
//  Copyright © 2019 Tianyun Shan. All rights reserved.
//

import Foundation


class FileWriter {

    /**
     Write "Word" model into `csv` String.
     */
    static func writeCsv(words: [Word]) -> String {
        var result: String = ""
        // Header
        result.append("Source\tTarget\tNote\n")
        for word in words {
            result.append("\(word.source ?? "")\t\(word.target ?? "")\t\(word.note ?? "")\n")
        }
        return result
    }

}
