//
//  MainViewModel.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

import Foundation
import RxSwift
import RxRelay

final class MainViewModel {
    
    let cellHeight: CGFloat = 100
    var inactiveWidgets = BehaviorRelay<[String]>(value: [])
    var activeWidgets = BehaviorRelay<[String]>(value: [])

    init() { }
    
    func retrieveData() {
        if UD.activeWidgets.isEmpty && UD.inactiveWidgets.isEmpty {
            UD.activeWidgets = ["Widget_1", "Widget_2", "Widget_3"]
            UD.inactiveWidgets = ["Widget_4"]
        }
        activeWidgets.accept(UD.activeWidgets)
        inactiveWidgets.accept(UD.inactiveWidgets)
    }
    
}
