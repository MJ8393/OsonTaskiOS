//
//  SettingsTableViewCell.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

import UIKit

protocol MainTableViewCellProtocol: AnyObject {
    func switchChanged(value: Bool, indexPath: IndexPath)
}

final class SettingsTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "MainTableViewCell"
    var indexPath: IndexPath?
    weak var delegate: MainTableViewCellProtocol?
    
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
    
    lazy var activeSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(faceSwitchChanged), for: .valueChanged)
        return mySwitch
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        self.backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Functions
    
    func setData(widget: String, indexPath: IndexPath) {
        widgetLabel.text = widget
        self.indexPath = indexPath
        activeSwitch.isOn = indexPath.section == 0 ? true  : false
    }
    
    // MARK: Actions
    
    @objc func faceSwitchChanged() {
        if let indexPath = indexPath {
            delegate?.switchChanged(value: activeSwitch.isOn, indexPath: indexPath)
        }
    }
}

// MARK: - Extension RootView

extension SettingsTableViewCell: RootView {

    func addSubviews() {
        addSubview(containerView)
        addSubview(widgetLabel)
        contentView.addSubview(activeSwitch)
    }
    
    func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.equalTo(self).offset(5)
            make.trailing.bottom.equalTo(self).offset(-5)
        }
        
        widgetLabel.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.centerY.equalTo(self)
            make.height.equalTo(25)
        }
        
        activeSwitch.snp.makeConstraints { make in
            make.leading.equalTo(containerView).offset(20)
            make.centerY.equalTo(containerView)
        }
    }
}

