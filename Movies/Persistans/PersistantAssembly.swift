//
//  PersistantAssembly.swift
//  Movies
//
//  Created by Андрей Коноплев on 16.10.2023.
//

import EasyDi

final class PersistantAssembly: Assembly {

    var movieCoreDataStack: CoreDataStackProtocol {
        define(scope: .lazySingleton,
               init: CoreDataStack(modelName: GlobalConstants.Persistant.movieDataStackName))
    }

    var movePersistantManager: MoviePersistantManagerProtocol {
        define(scope: .lazySingleton, init: MoviePersistantManager(coreDataStack: self.movieCoreDataStack))
    }

}


