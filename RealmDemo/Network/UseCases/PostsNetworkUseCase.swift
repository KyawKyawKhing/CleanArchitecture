//
//  PostsUseCase.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation
import RxSwift

final class PostsNetworkUseCase<Repository>: PostsDomainUseCase where Repository: AbstractCache, Repository.T == Post {
    
    private let network: PostsNetwork
    private let cache: Repository
    
    init(network: PostsNetwork, cache: Repository) {
        self.network = network
        self.cache = cache
    }
    
    func posts() -> Observable<[Post]> {
        let stored = network.fetchPosts()
            .flatMap {
                return self.cache.save(objects: $0)
                    .asObservable()
                    .map(to: [Post].self)
                    .concat(Observable.just($0))
        }
        let fetchPosts = cache.fetchObjects().asObservable()
        
        return fetchPosts.ifEmpty(switchTo: stored)
//        return stored
    }
    
    func save(post: Post) -> Observable<Void> {
        return network.createPost(post: post)
            .map { _ in }
    }
    
    func save(posts: [Post]) -> Observable<Void> {
        return network.createPost(post: posts.first!)
            .map { _ in }
    }
    
    func delete(post: Post) -> Observable<Void> {
        return network.deletePost(postId: post.uid).map({_ in})
    }
    
}

final class PostsNetworkUseCaseOld<Cache>: PostsDomainUseCase where Cache: AbstractCache, Cache.T == Post {
    
    private let network: PostsNetwork
    private let cache: Cache
    
    init(network: PostsNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
    func posts() -> Observable<[Post]> {
        let stored = network.fetchPosts()
            .flatMap {
                return self.cache.save(objects: $0)
                    .asObservable()
                    .map(to: [Post].self)
                    .concat(Observable.just($0))
        }
        let fetchPosts = cache.fetchObjects().asObservable()
        
        //        return fetchPosts.ifEmpty(switchTo: stored)
        return stored
    }
    
    func save(post: Post) -> Observable<Void> {
        return network.createPost(post: post)
            .map { _ in }
    }
    
    func save(posts: [Post]) -> Observable<Void> {
        return network.createPost(post: posts.first!)
            .map { _ in }
    }
    
    func delete(post: Post) -> Observable<Void> {
        return network.deletePost(postId: post.uid).map({_ in})
    }
    
}

struct MapFromNever: Error {}
extension ObservableType where Element == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}

