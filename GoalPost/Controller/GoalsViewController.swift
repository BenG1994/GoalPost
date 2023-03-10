//
//  GoalsViewController.swift
//  GoalPost
//
//  Created by Ben Gauger on 2/9/23.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate


class GoalsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
fetchCoreDataObjects()
//        self.fetch { complete in
//            if complete {
//                print("view will appear called")
//                if goals.count >= 1 {
//                    tableView.isHidden = false
//
//                }else {
//                    tableView.isHidden = true
//                }
//            }
//        }
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects(){
        self.fetch { complete in
            if complete {
                print("view will appear called")
                if goals.count >= 1 {
                    tableView.isHidden = false

                }else {
                    tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func addGoalButtonPressed(_ sender: Any) {
        print("button was pressed")
        
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        createGoalVC.modalPresentationStyle = .fullScreen
        present(createGoalVC, animated: true)
        
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
}

extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { rowAction, indexPath in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { rowAction, indexPath in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = UIColor.red
        addAction.backgroundColor = UIColor.orange
        
        return [deleteAction, addAction]
    }
    
    
    
}

extension GoalsViewController {
    
    func setProgress(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        }else{
            return
        }
        
        do{
            try managedContext.save()
            print("Successfully set progress")
        }catch{
            debugPrint("Could not set progess: \(error.localizedDescription)")
        }
        
        
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do{
            goals = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data")
            completion(true)
            
        }catch{
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContext.delete(goals[indexPath.row])
        
        do{
           try  managedContext.save()
            print("Successfully removed goal")
        }catch{
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
        
        
    }
    
}

