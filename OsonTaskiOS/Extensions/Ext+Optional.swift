//
//  Ext+Optional.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

import Foundation

extension Optional {
    var notNullString: String {
        switch self {
        case .some(let value): return String(describing: value)
        case .none : return ""
        }
    }
}
