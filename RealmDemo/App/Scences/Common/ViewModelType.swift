//
//  ViewModelType.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
