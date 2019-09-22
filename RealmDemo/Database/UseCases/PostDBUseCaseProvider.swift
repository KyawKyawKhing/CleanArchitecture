//
//  UseCaseProvider.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/21/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public final class PostDBUseCaseProvider: PostsDomainUseCaseProvider {
    
    private let configuration: Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    
    func makePostsDomainUseCase() -> PostsDomainUseCase {
        let repository = Repository<Post>(configuration: configuration)
        return PostsDBUseCase(repository: repository)
    }
}

