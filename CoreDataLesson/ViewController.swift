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

        // Ссылка на AppDelegate

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        // Создаем контекст

        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        // Описание сущности

        let entityDesription = NSEntityDescription.entity(forEntityName: "Person", in: context)

        // Создание объекта при classDefition

        // let manadedObject = NSManagedObject(entity: entityDesription!, insertInto: context)

        // Создание объекта при manual

        let manageObject = Person(entity: entityDesription!, insertInto: context)

        // Установка значений атрибутов при classDefition

        // manadedObject.setValue("Artem", forKey: "name")
        // manadedObject.setValue(32, forKey: "age")

        // Установка значений атрибутов при manual

        manageObject.name = "Denis"
        manageObject.age = 22

        // Извлекаем значение атрибута при classDefition

        // let name = manadedObject.value(forKey: "name")
        // let age = manadedObject.value(forKey: "age")
        // print("\(name), \(age)")

        // Извлекаем значение атрибута при manual

        let name = manageObject.name
        let age = manageObject.age

        // Сохранение данных

        appDelegate.saveContext()

        // Извлечение данных

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")

        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [Person] {
                print("name - \(result.name), age - \(result.age)")

            // при classDefition
            // for result in results as! [NSManagedObject] {
            // print("name - \(result.value(forKey: "name") ?? ""), age - \(result.value(forKey: "age") ?? 0)")
            }
        } catch {
            print(error )
        }

        // Удаление всех данных

        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                context.delete(result)
            }
        } catch {
            print(error)
        }

        // Сохраняем изменения

        appDelegate.saveContext()







    }


}

