//
//  TagParser.swift
//  xliff-csv
//
//  Created by Tianyun Shan on 2019-08-28.
//  Copyright © 2019 Tianyun Shan. All rights reserved.
//

import Foundation

/**
 Swift String extension for parsing xml and xliff.
 */
extension String {

    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /**
     Pass in the tag keyword and return the contents in between the tag. For example: `<source>ABCDE</source>`. Pass in `source` and will return `ABCDE`

     - Precondition: The tag needs to be inline tag.
     - Parameter tag: The tag keyword
     - Returns: return the content in between the tag keyword. If return `nil`, then the format for this String does not match the tag.
     */
    func tagContents(tag: String) -> String? {
        let fullOpening = "<\(tag)>"
        let fullClosing = "</\(tag)>"
        guard hasPrefix(fullOpening) else {
            // The string is not the tag.
            return nil
        }

        var result = self
        result.removeFirst(fullOpening.count)
        result.removeLast(fullClosing.count)
        return result
    }
}
