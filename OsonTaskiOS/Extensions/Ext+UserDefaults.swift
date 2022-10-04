//
//  UserDefaults.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

import Foundation

let UD = UserDefaults()

extension UserDefaults {
    
    var activeWidgets: [String] {
        get { return self.stringArray(forKey: "activeWidgets") ?? [] }
        set { self.set(newValue, forKey: "activeWidgets") }
    }
    
    var inactiveWidgets: [String] {
        get { return self.stringArray(forKey: "inactiveWidgets") ?? [] }
        set { self.set(newValue, forKey: "inactiveWidgets") }
    }
    
}
