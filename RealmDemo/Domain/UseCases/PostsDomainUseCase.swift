//
//  PostsDomainUseCase.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsDomainUseCase{
    func posts() -> Observable<[Post]>
    func save(post: Post) -> Observable<Void>
    func delete(post: Post) -> Observable<Void>
}
