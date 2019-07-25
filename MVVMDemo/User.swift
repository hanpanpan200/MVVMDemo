//
//  User.swift
//  MVVMDemo
//
//  Created by Panpan Han  on 2019/7/24.
//  Copyright © 2019 PanpanHan. All rights reserved.
//

import Foundation

class User {
    var username: String = ""
    var password: String = ""

    convenience init() {
        self.init(username: "", password: "")
    }

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
