//
//  OperationService.swift
//  Movies
//
//  Created by Андрей Коноплев on 15.10.2023.
//

import Foundation

class OperationService {
    private static var operationQueue = OperationQueue()

    static func cancelAllOperation() {
        operationQueue.cancelAllOperations()
    }

    static func addOperation(op: Operation, cancelingQueue cancelFlag: Bool) {
        self.operationQueue.maxConcurrentOperationCount = 1

        if cancelFlag {
            self.operationQueue.cancelAllOperations()
        }
        operationQueue.addOperation(op)
    }
}

