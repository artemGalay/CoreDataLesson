//
//  ViewController.swift
//  CoreDataLesson
//
//  Created by Артем Галай on 16.11.22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        // Ссылка на AppDelegate

//        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        // Создаем контекст

//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        // Описание сущности

//        let entityDesription = NSEntityDescription.entity(forEntityName: "Person", in: context)


        // Создание объекта при manual

//        let manageObject = Person(entity: CoreDataManager.instance.entityForName(entityName: "Person"), insertInto: CoreDataManager.instance.context)

        let manageObject = Person()

        // Установка значений атрибутов при manual

        manageObject.name = "Denis"
        manageObject.age = 22

        // Извлекаем значение атрибута при manual

        let name = manageObject.name
        let age = manageObject.age

        // Сохранение данных

//        appDelegate.saveContext()
        CoreDataManager.instance.saveContext()

        // Извлечение данных

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")

        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [Person] {
                print("name - \(result.name), age - \(result.age)")
            }
        } catch {
            print(error )
        }

        // Удаление всех данных

        do {
            let results = try CoreDataManager.instance.context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                CoreDataManager.instance.context.delete(result)
            }
        } catch {
            print(error)
        }

        // Сохраняем изменения

        CoreDataManager.instance.saveContext()
    }
}
