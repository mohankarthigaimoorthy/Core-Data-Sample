//
//  ViewController.swift
//  dataMining
//
//  Created by Mohan K on 10/03/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var employeeTable: UITableView!
  
    let context = (UIApplication.shared.delegate as!AppDelegate) .persistentContainer.viewContext
    
    var item:[Employee]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tablesetup ()
        fetchEmployee()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .done, target: self, action: #selector(didupdate))
    }

    @objc func didupdate () {
        let alert = UIAlertController(title: "Add Person Data", message: "Enter Given Below Space", preferredStyle: .alert)
       
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        
        let submitBtn = UIAlertAction(title: "Add", style: .default) {
            
            (action) in
         
            let empidTextField = alert.textFields![0]
            let empnameTextField  = alert.textFields![1]
            let empsalaryTextField  = alert.textFields![2]
            let emppositionTextField = alert.textFields![3]
            let empageTextField = alert.textFields![4]
            
            let newPerson = Employee(context: self.context)
            newPerson.empid = 00
            newPerson.empname =  empnameTextField.text
            newPerson.empsalary = 2000
            newPerson.empposition = emppositionTextField.text
            newPerson.empage = 33
            do {
                
                try self.context.save()
            }
            catch {
                
            }
            self.fetchEmployee()
        }
        alert.addAction(submitBtn)
        self.present(alert, animated: true, completion: nil)
    }
    func tablesetup () {
        employeeTable.delegate = self
        employeeTable.dataSource = self
        DispatchQueue.main.async {
            self.employeeTable.reloadData()
        }
    }
    func fetchEmployee() {
        do {
            self.item = try context.fetch(Employee.fetchRequest())
            DispatchQueue.main.async {
                self.employeeTable.reloadData()
            }
        }
        catch {
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTable.dequeueReusableCell(withIdentifier: "employeeTableViewCell", for: indexPath) as! employeeTableViewCell
        let person = self.item![indexPath.row]
        cell.text1.text = "\(person.empid)"
        cell.text2.text = person.empname
        cell.text3.text = "\(person.empsalary)"
        cell.text4.text = person.empposition
        cell.text5.text = "\(person.empage)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = self.item![indexPath.row]
    
        let alert = UIAlertController(title: "Edit", message: "edit name: ", preferredStyle: .alert)
     
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()

        let empidTextField = alert.textFields![0]
        let empnameTextField  = alert.textFields![1]
        let empsalaryTextField  = alert.textFields![2]
        let emppositionTextField = alert.textFields![3]
        let empageTextField = alert.textFields![4]
        
         empidTextField.text = "\(person.empid)"
         empnameTextField.text =  person.empname
         empsalaryTextField.text = "\(person.empsalary)"
         emppositionTextField.text = person.empposition
         empageTextField.text = "\(person.empage)"

        
        let saveBtn = UIAlertAction(title: "Save", style: .default) {
            (action) in
            
            
            let empidTextField = alert.textFields![0]
            let empnameTextField  = alert.textFields![1]
            let empsalaryTextField  = alert.textFields![2]
            let emppositionTextField = alert.textFields![3]
            let empageTextField = alert.textFields![4]
            
             empidTextField.text = "\(person.empid)"
             empnameTextField.text =  person.empname
             empsalaryTextField.text = "\(person.empsalary)"
             emppositionTextField.text = person.empposition
             empageTextField.text = "\(person.empage)"

            
        
        do {
            try self.context.save()
        }
        catch{
            
        }
        self.fetchEmployee()
    }
        alert.addAction(saveBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action , view, completionHandler) in
            
            let personToRemove = self.item![indexPath.row]
            self.context.delete(personToRemove)
            do {
                try self.context.save()
            }
            catch{
                
            }
            self.fetchEmployee()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
