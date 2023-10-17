//
//  HTTPResponse.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public enum Result {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
