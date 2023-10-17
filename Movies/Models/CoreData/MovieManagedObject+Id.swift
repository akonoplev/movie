//
//  MovieManagedObject+Id.swift
//  Movies
//
//  Created by Андрей Коноплев on 16.10.2023.
//

import Foundation

extension MovieManagedObject: MovieProtocol {
    public var id: Int? {
        return Int(id32)
    }
}
