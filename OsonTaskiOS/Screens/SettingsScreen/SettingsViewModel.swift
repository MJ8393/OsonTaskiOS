//
//  SettingsViewModel.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

import Foundation
import RxSwift
import RxRelay

final class SettingsViewModel {
    
    let sections: [String] = ["Active", "Inactive"]
    let cellHeight: CGFloat = 100
    var widgets = BehaviorRelay<[[String]]>(value: [[], []])
    
    init() { }
    
    func retrieveData() {
        var widgets = [[String]]()
        widgets.append(UD.activeWidgets)
        widgets.append(UD.inactiveWidgets)
        self.widgets.accept(widgets)
    }
}
