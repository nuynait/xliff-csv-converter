//
//  main.swift
//  xliff-csv
//
//  Created by Tianyun Shan on 2019-08-28.
//  Copyright © 2019 Tianyun Shan. All rights reserved.
//

import Foundation


let words = FileReader.readXliff(path: "~/Downloads/fr-CA.xliff")
let result = FileWriter.writeCsv(words: words)
try? result.write(to: URL(fileURLWithPath: ("~/Downloads/result.csv" as NSString).expandingTildeInPath), atomically: true, encoding: String.Encoding.utf8)
