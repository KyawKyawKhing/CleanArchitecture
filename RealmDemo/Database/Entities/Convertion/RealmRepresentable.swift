//
//  RealmRepresentable.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DBDomainConvertibleType
    
    var uid: String {get}
    
    func asRealm() -> RealmType
}

