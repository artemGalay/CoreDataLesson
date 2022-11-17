//
//  DetailViewController.swift
//  CoreDataLesson
//
//  Created by Артем Галай on 17.11.22.
//

import UIKit

class DetailViewController: UIViewController {

    var person: Person?
    
    private lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var pressButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Press", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pressButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        // Чтение объекта
        if let person = person {
            userTextField.text = person.name
            ageTextField.text = String(person.age)
        }
    }

    private func setupHierarchy() {
        view.addSubview(userTextField)
        view.addSubview(ageTextField)
        view.addSubview(pressButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userTextField.heightAnchor.constraint(equalToConstant: 50),

            ageTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ageTextField.heightAnchor.constraint(equalToConstant: 50),

            pressButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            pressButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pressButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    @objc private func pressButtonTapped() {
        // Создаем объект
        if person == nil {
            person = Person()
        }

        if let person = person {
            person.name = userTextField.text
            person.age = Int16(ageTextField.text!)!
            CoreDataManager.instance.saveContext()
        }
    }
}
