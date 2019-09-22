//
//  Injection.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation

class Injection{
    static func providePostNetworkUserCaseProvider() -> PostsDomainUseCaseProvider{
        return PostsNetworkUseCaseProvider()
    }
    static func providePostDBUserCaseProvider() -> PostsDomainUseCaseProvider{
        return PostDBUseCaseProvider()
    }
}
