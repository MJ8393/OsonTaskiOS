//
//  MainPageViewController.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

import UIKit
import SnapKit
import RxSwift

class MainPageViewController: BaseViewController {
    
    // MARK: Properties
    
    private let viewModel: MainViewModel
    private let bag = DisposeBag()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Outlets
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.systemGreen
        button.setTitle("Widget settings", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(widgetSettingsTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: ViewController Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrieveData()
    }
    
    // MARK: Functions
    
    private func configureNavigationBar() {
        title = "Main Page"
    }
    
    // MARK: Actions
    
    @objc func widgetSettingsTapped() {
        let vc = SettingsViewController(viewModel: SettingsViewModel())
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - Extension RootView

extension MainPageViewController: RootView {
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(settingsButton)
    }
    
    func setConstraints() {
        settingsButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-50)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.bottom.equalTo(settingsButton.snp.top).offset(-20)
        }
    }
    
    func bindElements() {
        viewModel.activeWidgets.subscribe(onNext: { [weak self] repos in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }).disposed(by: bag)
    }
}



// MARK: - Extension UITableViewDelegate and UITableViewDataSource

extension MainPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.setContent(with: viewModel.activeWidgets.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.activeWidgets.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight
    }
    
}
