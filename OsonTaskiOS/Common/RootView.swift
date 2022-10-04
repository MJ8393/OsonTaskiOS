//
//  RootView.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

protocol RootView {
    func configureUI()
    
    func addSubviews()
    func setConstraints()
    func bindElements()
}

extension RootView {
    func configureUI() {
        addSubviews()
        setConstraints()
        bindElements()
    }
    
    func bindElements() { }
}
