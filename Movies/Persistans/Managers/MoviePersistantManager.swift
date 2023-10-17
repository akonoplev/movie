//
//  MoviePersistantManager.swift
//  Movies
//
//  Created by Андрей Коноплев on 16.10.2023.
//

import CoreData

protocol MoviePersistantManagerProtocol {
    func saveMovies(_ movies: [MovieProtocol])
    func getMovies() -> [MovieProtocol]
}

final class MoviePersistantManager: MoviePersistantManagerProtocol {

    let coreDataStack: CoreDataStackProtocol

    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }

    func saveMovies(_ movies: [MovieProtocol]) {
        let context = coreDataStack.backgroundContext

        context.perform {
            for movie in movies {
                let fetchRequest: NSFetchRequest<MovieManagedObject> = MovieManagedObject.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id32 == %d", movie.id ?? 0)

                do {
                    if let result = try context.fetch(fetchRequest).first {
                        result.title = movie.title
                        result.overview = movie.overview
                        result.release_date = movie.release_date
                        result.poster_path = movie.poster_path
                    } else {
                        let movieManagedObject = MovieManagedObject(context: context)
                        movieManagedObject.id32 = Int32(movie.id ?? 0)
                        movieManagedObject.title = movie.title
                        movieManagedObject.overview = movie.overview
                        movieManagedObject.release_date = movie.release_date
                        movieManagedObject.poster_path = movie.poster_path
                    }
                } catch {
                    print("Failed to fetch or save movies: \(error)")
                }
            }

            self.coreDataStack.saveContext(context)
        }
    }

    func getMovies() -> [MovieProtocol] {
        let fetchRequest: NSFetchRequest<MovieManagedObject> = MovieManagedObject.fetchRequest()
        do {
            let result = try coreDataStack.mainContext.fetch(fetchRequest)
            return result
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
}

