//
//  PostsUseCase.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/21/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

final class PostsDBUseCase<Repository>: PostsDomainUseCase where Repository: AbstractRepository, Repository.T == Post {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func posts() -> Observable<[Post]> {
        return repository.queryAll()
    }
    
    func save(post: Post) -> Observable<Void> {
        return repository.save(entity: post)
    }
    
    func save(posts: [Post]) -> Observable<Void> {
        let postList = posts.map{ $0.asRealm()}
        return repository.save(entity: posts)
    }
    
    
    
    func delete(post: Post) -> Observable<Void> {
        return repository.delete(entity: post)
    }
}

