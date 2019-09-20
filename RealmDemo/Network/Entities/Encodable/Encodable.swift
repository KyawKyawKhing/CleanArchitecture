//
//  Encodable.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation

protocol DomainConvertibleType {
    associatedtype DomainType: Identifiable
    
    init(with domain: DomainType)
    
    func asDomain() -> DomainType
}

protocol Identifiable {
    var uid: String { get }
}

typealias DomainConvertibleCoding = DomainConvertibleType

protocol Encodable {
    associatedtype Encoder: DomainConvertibleCoding
    
    var encoder: Encoder { get }
}
