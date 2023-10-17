//
//  GlobalConstants.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

enum GlobalConstants { }

extension GlobalConstants {
    enum API {
        static let baseURL = "https://api.themoviedb.org/3"
        static let imgURL = "https://image.tmdb.org/t/p/original"
        static let apiKey = "5163a757e85c4611696ff6b75bc8bd02"
        static let apiReadAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MTYzYTc1N2U4NWM0NjExNjk2ZmY2Yjc1YmM4YmQwMiIsInN1YiI6IjY1Mjg4Zjc1NjI5YjJjMDBhYzVmZTdmMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BXxpRHENhrDQzdSOpslQeeg-dUwjUBD_LVT9yzffg6U"
    }

    enum Persistant {
        static let movieDataStackName = "MovieDataStackModel"
    }
}
