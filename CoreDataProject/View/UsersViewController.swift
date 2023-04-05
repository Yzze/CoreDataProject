//
//  ViewController.swift
//  CoreDataProject
//
//  Created by Ян Жигурс on 05.04.2023.
//

import UIKit

class UsersViewController: UIViewController {
    
    private let presenter = Presenter()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Enter your name..."
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Add user", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getAllItems()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        presenter.getAllItems()
        setupHierarchy()
        setupLayout()
    }
    
    func setupHierarchy() {
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            textField.heightAnchor.constraint(equalToConstant: 45),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.topAnchor, constant: 70),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            button.heightAnchor.constraint(equalToConstant: 45),
            
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: button.topAnchor, constant: 100),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func didTapAdd() {
        guard let text = textField.text, ((textField.text?.isEmpty) != nil) else {
            return
        }
        self.presenter.createItem(name: text)
        textField.text = ""
        tableView.reloadData()
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteItem(item: presenter.models[indexPath.row])
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        viewController.person = presenter.models[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
