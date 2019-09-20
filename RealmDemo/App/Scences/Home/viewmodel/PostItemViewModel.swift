//
//  PostItemViewModel.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation

final class PostItemViewModel   {
    let title:String
    let subtitle : String
    let post: Post
    init (with post:Post) {
        self.post = post
        self.title = post.title.uppercased()
        self.subtitle = post.body
    }
}
