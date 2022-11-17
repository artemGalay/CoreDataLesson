//
//  ViewController.swift
//  CoreDataLesson
//
//  Created by Артем Галай on 16.11.22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    struct Constants {
        static let entity = "Person"
        static let sortName = "name"
        static let cell = "cell"
    }

    var person: Person?

    var fetchResultController = CoreDataManager.instance.fetchResultController(entityName: Constants.entity, sortName: Constants.sortName)
    
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

    private lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGray6
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchResultController.delegate = self
        setupHierarchy()
        setupLayout()

        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }


//
//        let manageObject = Person()
//
//        // Установка значений атрибутов при manual
//
//        manageObject.name = "Petr"
//        manageObject.age = 23
//
//        // Извлекаем значение атрибута при manual
//
//        let name = manageObject.name
//        let age = manageObject.age
//
//        // Сохранение данных
//
//        //        appDelegate.saveContext()
//        CoreDataManager.instance.saveContext()
//
//        // Извлечение данных
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//
//        do {
//            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
//            for result in results as! [Person] {
//                print("name - \(result.name), age - \(result.age)")
//            }
//        } catch {
//            print(error )
//        }

        // Удаление всех данных

        //        do {
        //            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
        //            for result in results as! [NSManagedObject] {
        //                CoreDataManager.instance.context.delete(result)
        //            }
        //        } catch {
        //            print(error)
        //        }
        //
        //        // Сохраняем изменения
        //
        //        CoreDataManager.instance.saveContext()
        //    }
    }

    private func setupHierarchy() {
        view.addSubview(userTextField)
        view.addSubview(ageTextField)
        view.addSubview(pressButton)
        view.addSubview(usersTableView)
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
            pressButton.heightAnchor.constraint(equalToConstant: 50),

            usersTableView.topAnchor.constraint(equalTo: pressButton.bottomAnchor, constant: 20),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
            userTextField.text = nil
            ageTextField.text = nil
            userTextField.becomeFirstResponder()
            self.person = nil
        }
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        fetchResultController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        let person = fetchResultController.object(at: indexPath) as! Person
        cell = UITableViewCell(style: .value1, reuseIdentifier: Constants.cell)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = String(person.age)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = fetchResultController.object(at: indexPath) as! Person
            CoreDataManager.instance.context.delete(person)
            CoreDataManager.instance.saveContext()
        }

        }
    }


extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        let person = fetchResultController.object(at: indexPath) as! Person
        viewController.person = person
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {

    // Информирует о начале изменения данных
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        usersTableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                usersTableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let person = fetchResultController.object(at: indexPath) as! Person
                let cell = usersTableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = person.name
                cell?.detailTextLabel?.text = String(person.age)
            }
        case .move:
            if let indexPath = indexPath {
                usersTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                usersTableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                usersTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }

    // Информирует о окончании изменении данных
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        usersTableView.endUpdates()
    }
}
