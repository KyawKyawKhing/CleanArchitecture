//
//  NetworkProvider.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "https://jsonplaceholder.typicode.com"
    }
    
    public func makePostsNetwork() -> PostsNetwork {
        let network = Network<Post>(apiEndpoint)
        return PostsNetwork(network: network)
    }
}
