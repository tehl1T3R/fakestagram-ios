//
//  AccountRepo.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class AccountRepo {
    let shared = AccountRepo()

    static func loadOrCreate(success: (Account) -> Void) {
        if let account = load() {
            success(account)
            return
        }
        let newAccount = Account.initialize()
        create(newAccount, success: success)
    }

    static func load() -> Account? {
        return nil
    }
    
    static func create(_ account: Account, success: (Account) -> Void) {
        
    }
}
