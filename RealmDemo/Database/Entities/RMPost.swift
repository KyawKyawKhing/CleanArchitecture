//
//  RMPost.swift
//  RealmDemo
//
//  Created by Kyaw Kyaw Khing on 9/20/19.
//  Copyright © 2019 Kyaw Kyaw Khing. All rights reserved.
//

import Foundation
import QueryKit
import RealmSwift
import Realm

final class RMPost: Object {
    @objc dynamic var uid: String = ""
    @objc dynamic var userId: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var createdAt: String = ""
    
    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension RMPost {
    static var title: Attribute<String> { return Attribute("title")}
    static var body: Attribute<String> { return Attribute("body")}
    static var userId: Attribute<String> { return Attribute("userId")}
    static var uid: Attribute<String> { return Attribute("uid")}
    static var createdAt: Attribute<String> { return Attribute("createdAt")}
}

extension RMPost: DBDomainConvertibleType {
    func asDomain() -> Post {
        return Post(body: body,
                    title: title,
                    uid: uid,
                    userId: userId,
                    createdAt: createdAt)
    }
}

extension Post: RealmRepresentable {
    func asRealm() -> RMPost {
        return RMPost.build { object in
            object.uid = uid
            object.userId = userId
            object.title = title
            object.body = body
            object.createdAt = createdAt
        }
    }
}
