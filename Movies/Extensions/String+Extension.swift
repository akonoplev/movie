//
//  String+Extension.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

// MARK: - decode unicode charecters
extension String {
    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
}
