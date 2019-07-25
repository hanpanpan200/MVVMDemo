//
//  File.swift
//  MVVMDemo
//
//  Created by Panpan Han  on 2019/7/24.
//  Copyright © 2019 PanpanHan. All rights reserved.
//

import Foundation

enum UserValidateStatus {
    case Invalid(message: String)
    case Valid
}

class UserViewModel {
    private let minUsernameLength = 8
    private let minPasswordLength = 16
    private var user = User()

    var username: String {
        get {
            return user.username
        }
        set(newUsername) {
            user.username = newUsername
        }
    }

    var password: String {
        get {
            return user.password
        }
        set(newPassword) {
            user.password = newPassword
        }
    }

    var protectedUsername: String {
        let usernameLength = username.count
        if usernameLength >= minUsernameLength {
            var displayName = [Character]()
            for (index, character) in username.enumerated() {
                if index > usernameLength - minUsernameLength {
                    displayName.append(character)
                } else {
                    displayName.append("*")
                }
            }
            return String(displayName)
        }
        return user.username
    }
}

extension UserViewModel {

    private func validate() -> UserValidateStatus {
        if username.isEmpty || password.isEmpty {
            return .Invalid(message: "Username and password are required.")
        }
        if username.count < minUsernameLength {
            return .Invalid(message: "Username should be longer than \(minUsernameLength)")
        }
        if password.count < minPasswordLength {
            return .Invalid(message: "Password should be long than \(minPasswordLength)")
        }
        return .Valid
    }

    func login(completion: (_ title: String, _ message: String) -> Void) {
        let validStatus = validate()
        switch validStatus {
        case .Invalid(let message):
            completion("Failed", message)
        default:
            completion("Success", "Welcome!")
        }
        //TODO: integrate http request
        print("Send http request to login")
    }
}
