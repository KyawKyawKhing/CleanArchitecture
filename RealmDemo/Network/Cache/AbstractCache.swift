//
//  AbstractCache.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation
import RxSwift

protocol AbstractCache {
    associatedtype T
    func save(object: T) -> Completable
    func save(objects: [T]) -> Completable
    func fetch(withID id: String) -> Maybe<T>
    func fetchObjects() -> Maybe<[T]>
}
