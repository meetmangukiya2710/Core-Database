//
//  ViewController.swift
//  Core Database
//
//  Created by R95 on 08/02/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var newIdTextField: UITextField!
    
    @IBOutlet weak var newNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addDataButtonAction(_ sender: Any) {
            addData(id: Int(idTextField.text ?? "") ?? 0, name: nameTextField.text ?? "")
        }
        
        @IBAction func getDataButtonAction(_ sender: Any) {
            getData()
        }
        
        @IBAction func deleteDataButtonActon(_ sender: Any) {
            deleteData(id: Int(idTextField.text ?? "") ?? 0,name: nameTextField.text ?? "")
        }
        
        @IBAction func updateDataButtonActon(_ sender: Any) {
            updateData(id: Int(idTextField.text ?? "") ?? 0,name: nameTextField.text ?? "",newId: Int(newIdTextField.text ?? "") ?? 00 ,newName: newNameTextField.text ?? "")
        }
        
        func addData(id : Int ,name: String){
            
            guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else {return }
            let context = appDeleget.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "Student", in: context)
            
            let user = NSManagedObject(entity: userEntity!, insertInto: context)
            user.setValue(id, forKey: "id")
            user.setValue(name, forKey: "name")
            
            appDeleget.saveContext()
            print("Your Data Is Save")
            
        }
        
        func getData(){
            
            guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else {return }
            let context = appDeleget.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
            
            do {
                let result = try context.fetch(fetchRequest)
                for i in result as! [NSManagedObject] {
                    print(i.value(forKey: "id") as! Int)
                    print(i.value(forKey: "name") as! String)
                }
                print("\n Get Data \n")
                appDeleget.saveContext()
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
        
        func deleteData(id:Int,name:String){
            guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else {return }
            let context = appDeleget.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
            
            do {
                let result = try context.fetch(fetchRequest)
                let objectToDelete = result[0] as! NSManagedObject
                context.delete(objectToDelete)
                appDeleget.saveContext()
                print("\n Delete Data\n")
                
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
        
        func updateData(id:Int,name:String,newId:Int,newName:String){
            guard let appDeleget = UIApplication.shared.delegate as? AppDelegate else {return }
            let context = appDeleget.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            fetchRequest.predicate = NSPredicate(format: "name = %@", name)
            
            do {
                let result = try context.fetch(fetchRequest)
                let objectToUpdate = result[0] as! NSManagedObject
                objectToUpdate.setValue(newId, forKey: "id")
                objectToUpdate.setValue(newName, forKey: "name")
                
                print("\n Update Data \n")
            }
            catch {
                print(error.localizedDescription)
            }
        }
}

