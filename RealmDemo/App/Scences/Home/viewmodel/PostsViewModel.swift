//
//  PostsViewModel.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PostsViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
//        let createPostTrigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    struct Output {
        let fetching: Driver<Bool>
        let posts: Observable<[PostItemViewModel]>
//        let createPost: Driver<Void>
//        let selectedPost: Driver<Post>
        let error: Driver<Error>
    }
    
    private let networkUseCase: PostsDomainUseCase
    private let databaseUseCase: PostsDomainUseCase
    
    init(networkUseCase: PostsDomainUseCase,databaseUseCase: PostsDomainUseCase) {
        self.networkUseCase = networkUseCase
        self.databaseUseCase = databaseUseCase
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
//        let posts = input.trigger.flatMapLatest {_ in
//            self.networkUseCase.posts()
//            .flatMap { posts -> Observable<Void> in
//                return self.databaseUseCase.save(posts: posts)
//            }.flatMap{
//                return self.databaseUseCase.posts()
//        }
//                .asDriver(onErrorRecover: { (error) -> SharedSequence<DriverSharingStrategy, [Post]> in
//                    return self.databaseUseCase.posts().asDriverOnErrorJustComplete()
//                })
//            return self.networkUseCase.posts().asDriver(onErrorRecover: { (error) -> SharedSequence<DriverSharingStrategy, [Post]> in
//            return self.databaseUseCase.posts().asDriver(onErrorJustReturn: [])
//            })
//                .flatMap{ posts -> SharedSequence<DriverSharingStrategy, Void> in
//                return self.databaseUseCase.save(posts: posts).asDriverOnErrorJustComplete()
//                }.flatMap{_ in
//                                    return self.databaseUseCase.posts().asDriverOnErrorJustComplete()
//                            }
//            .trackActivity(activityIndicator)
////            .trackError(errorTracker)
//            .asDriverOnErrorJustComplete()
////                .asDriver()
//            .map { $0.map {
//                PostItemViewModel(with: $0)
////
//                } }
//        }.asObservable()
        let posts = input.trigger.flatMapLatest {
            return self.networkUseCase.posts()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { PostItemViewModel(with: $0) } }
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
//        let selectedPost = input.selection
//            .withLatestFrom(posts) { (indexPath, posts) -> Post in
//                return posts[indexPath.row].post
//            }
//            .do(onNext: navigator.toPost)
//        let createPost = input.createPostTrigger
//            .do(onNext: navigator.toCreatePost)
        
        return Output(fetching: fetching,
                      posts: posts.asObservable(),
//                      createPost: createPost,
//                      selectedPost: selectedPost,
                      error: errors)
    }
}
