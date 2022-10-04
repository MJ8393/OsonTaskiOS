//
//  SettingsViewController.swift
//  OsonTaskiOS
//
//  Created by Mekhriddin Jumaev on 04/10/22.
//

import UIKit
import RxSwift

class SettingsViewController: BaseViewController {
    
    // MARK: Properties
    
    private let viewModel: SettingsViewModel
    private let bag = DisposeBag()
    
    // MARK: Init
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    
    // MARK: Outlets
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.setEditing(true, animated: true)
        return tableView
    }()
    
    // MARK: View Controller Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrieveData()
    }
    
    // MARK: Functions
    
    private func configureNavigation() {
        title = "Widget Settings"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: Actions
    
    @objc func addButtonTapped() {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create a new Widget", message: nil, preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Widget name"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            var array = self.viewModel.widgets.value
            array[1].append(textField.text.notNullString)
            self.viewModel.widgets.accept(array)
        }
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}

// MARK: - Extension RootView

extension SettingsViewController: RootView {
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bindElements() {
        viewModel.widgets.subscribe(onNext: { [weak self] repos in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                UD.activeWidgets = repos[0]
                UD.inactiveWidgets = repos[1]
            }
        }).disposed(by: bag)
    }
}


// MARK: - Extension UITableViewDataSource
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        
        let text = viewModel.widgets.value[indexPath.section][indexPath.row]
        cell.setData(widget: text, indexPath: indexPath)
        
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.widgets.value[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section]
    }
}

// MARK: - Extension for moving the rows

extension SettingsViewController {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let selectedItem = viewModel.widgets.value[sourceIndexPath.section][sourceIndexPath.row]
        var array = viewModel.widgets.value
        array[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        array[destinationIndexPath.section].insert(selectedItem, at: destinationIndexPath.row)
        viewModel.widgets.accept(array)
    }
}

extension SettingsViewController: MainTableViewCellProtocol {
    func switchChanged(value: Bool, indexPath: IndexPath) {
        if value {
            let item = viewModel.widgets.value[indexPath.section][indexPath.row]
            var array = viewModel.widgets.value
            array[indexPath.section].remove(at: indexPath.row)
            array[0].append(item)
            viewModel.widgets.accept(array)
        } else {
            let item = viewModel.widgets.value[indexPath.section][indexPath.row]
            var array = viewModel.widgets.value
            array[indexPath.section].remove(at: indexPath.row)
            array[1].insert(item, at: 0)
            viewModel.widgets.accept(array)
        }
    }
}

