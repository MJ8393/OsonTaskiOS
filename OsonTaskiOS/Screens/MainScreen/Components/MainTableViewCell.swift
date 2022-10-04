//
//  MainTableViewCell.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "MainTableViewCell"
    
    // MARK: Outlets
    
    private let containerView: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.systemGray6
         view.layer.cornerRadius = 10
         return view
     }()

    
    private let widgetLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func setContent(with text: String) {
        widgetLabel.text = text
    }
}

// MARK: - Extension RootView

extension MainTableViewCell: RootView {

    func addSubviews() {
        addSubview(containerView)
        addSubview(widgetLabel)
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(5)
            make.trailing.bottom.equalTo(self).offset(-5)
        }
        
        widgetLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalTo(self)
            make.height.equalTo(25)
        }
    }
}
